//
//  OrderSheetView.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/11/25.
//

import SwiftUI
import MapKit

struct OrderSheetView: View {
    @Bindable var viewModel: OrderSheetViewModel = .init()
    
    @State private var isMapView: Bool = false
    @State private var hasDraggedMap: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                Capsule(style: .circular)
                    .fill(.gray04)
                    .frame(width: 70, height: 4)
                    .padding(.top, 10)
                
                navBar
                
                topView
                
                Divider()
                    .background(.gray07)
                    .padding(.top, 17)
            }
            .padding(.horizontal, 32.5)
            
            if isMapView {
                mapView
            } else {
                storeListView
            }
        }
        .onAppear {
            viewModel.loadStores()
        }
        .task {
            await viewModel.calculateDistanceFromCurrentLocation()
        }
    }
    
    // 내비게이션바
    private var navBar: some View {
        HStack {
            Rectangle()
                .fill(.clear)
                .frame(width: 24, height: 24)
            
            Spacer()
            
            Text("매장 설정")
                .font(.pretendardMedium(16))
                .foregroundStyle(.black03)
            
            Spacer()
            
            Button(action : {
                withAnimation {
                    isMapView.toggle()
                }
            }) {
                Image("map")
            }
        }
        .padding(.vertical, 24)
    }
    
    // 검색바랑 세그먼트
    private var topView: some View {
        VStack(alignment: .leading, spacing: 22) {
            TextField("검색", text: $viewModel.searchKeyword)
                .padding(.leading, 7)
                .font(.pretendardRegular(13))
                .foregroundStyle(.black01)
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.gray08)
                        .frame(height: 27)
                )
            
            segmentView
        }
    }
    
    // 가까운 매장 | 자주 가는 매장 세그먼트
    private var segmentView: some View {
        HStack(spacing: 0) {
            ForEach(OrderSheetSegment.allCases, id: \.id) { segment in
                sheetSegment(segment: segment)
            }
        }
    }
    
    // 세그먼트 개별 뷰
    func sheetSegment(segment: OrderSheetSegment) -> some View {
        HStack(spacing: 0) {
            Text(segment.title)
                .foregroundStyle(viewModel.selectedSegment == segment ? .black03 : .gray03)
                .font(.pretendardSemiBold(13))
                .onTapGesture {
                    withAnimation {
                        viewModel.selectedSegment = segment
                    }
                }
            
            if segment != OrderSheetSegment.allCases.last {
                Image("verticalLine")
                    .padding(.horizontal, 10)
            }
        }
    }
    
    // 매장 리스트 뷰
    private var storeListView: some View {
        ScrollView(.vertical, content: {
            LazyVStack(spacing: 16, content: {
                if let stores = viewModel.stores {
                    ForEach(stores.indices, id: \.self) { index in
                        StoreListItem(model: stores[index])
                            .padding(.top, index == 0 ? 28 : 0)
                    }
                }
            })
        })
        .padding(.horizontal, 32.5)
    }
    
    // 맵뷰
    private var mapView: some View {
        ZStack(alignment: .top) {
            Map(position: $viewModel.cameraPosition) {
                if let stores = viewModel.pinStores {
                    ForEach(stores, id: \.properties.Seq, content: { store in
                        let location = CLLocationCoordinate2D(
                            latitude: store.properties.Ycoordinate,
                            longitude: store.properties.Xcoordinate
                        )
                        
                        Annotation(store.properties.Sotre_nm, coordinate: location, content: {
                            ZStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle( .green02)
                                
                                Image("Starbucks")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        })
                    })
                    
                    UserAnnotation(anchor: .center)
                }
            }
            .onMapCameraChange { context in
                viewModel.visibleRegion = context.region
                hasDraggedMap = true
            }
            
            if hasDraggedMap {
                Button(action : {
                    print("버튼 클릭")
                    viewModel.calculateDistanceFromRegionCenter()
                    hasDraggedMap = false
                }) {
                    Text("이 지역 검색")
                        .font(.pretendardMedium(13))
                        .foregroundStyle(.gray06)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .frame(width: 88, height: 36)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                        )
                }
                .offset(y: 25)
            }
        }
    }
}

#Preview {
    OrderSheetView()
}

//
//  FindStoreView.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/11/25.
//

import SwiftUI
import MapKit

struct FindStoreView: View {
    @Environment(NavigationRouter.self) private var router
    @Bindable var viewModel: OrderSheetViewModel = .init()
    
    @State var selectedSegment: FindStoreSegment = .first
    @State var hasDraggedMap: Bool = false
    @State var isMapInitialized: Bool = false
    @Namespace var mapScope
    
    var body: some View {
        VStack(alignment: .center, spacing: 17) {
            CustomNavBar(title: "매장 찾기", onBack: {
                router.pop()
            })
            
            segmentView
            
            mapView
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            Task {
                await viewModel.loadStores()
            }
        }
        .task {
            await viewModel.calculateDistanceFromCurrentLocation()
        }
    }
    
    // 가까운 매장 | 자주 가는 매장 세그먼트
    private var segmentView: some View {
        HStack(spacing: 0) {
            ForEach(FindStoreSegment.allCases, id: \.id) { segment in
                findStoreSegment(segment: segment)
            }
        }
    }
    
    // 세그먼트 개별 뷰
    func findStoreSegment(segment: FindStoreSegment) -> some View {
        VStack(spacing: 10) {
            Text(segment.title)
                .foregroundStyle(selectedSegment == segment ? .black03 : .gray03)
                .font(.pretendardSemiBold(16))
                .onTapGesture {
                    withAnimation {
                        selectedSegment = segment
                    }
                }
            
            if selectedSegment == segment {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.brown02)
                    .frame(height: 3)
                    .padding(.horizontal, 20)
            } else {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 3)
            }
        }
    }
    
    // 맵뷰
    private var mapView: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .top) {
                Map(position: $viewModel.cameraPosition, scope: mapScope) {
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
                .onAppear {
                    isMapInitialized = true
                }
                .onMapCameraChange { context in
                    viewModel.visibleRegion = context.region
                    
                    print(hasDraggedMap)
                    print(isMapInitialized)
                    
                    if !hasDraggedMap && isMapInitialized {
                        hasDraggedMap = true
                    }
                }
                
                if hasDraggedMap {
                    localSearchBtn
                }
            }
            
            MapUserLocationButton(scope: mapScope)
                .overlay(content: {
                    Image("location-fill")
                })
                .tint(.clear)
                .offset(x: -30, y: -30)
        }
        .mapScope(mapScope)
    }
    
    private var localSearchBtn: some View {
        Button(action : {
            print("이 지역 검색")
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

#Preview {
    FindStoreView()
        .environment(NavigationRouter())
}

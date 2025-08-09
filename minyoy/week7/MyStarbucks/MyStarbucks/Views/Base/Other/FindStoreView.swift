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
    @State var isLoadingRoute: Bool = false
    
    @Namespace var mapScope
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 17) {
                CustomNavBar(title: "매장 찾기", onBack: {
                    router.pop()
                })
                
                segmentView
                
                if selectedSegment == .first {
                    mapView
                } else {
                    directionsView
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear {
                viewModel.loadStores()
            }
            .task {
                await viewModel.calculateDistanceFromCurrentLocation()
            }
            
            // 경로 찾기 프로그레스
            if isLoadingRoute {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                            
                            HStack(spacing: 8) {
                                ProgressView()
                                    .scaleEffect(1.3)
                                    .background(.clear)
                                    .tint(.green00)

                                Text("경로 검색 중..")
                                    .foregroundColor(.white)
                                    .font(.pretendardRegular(17))
                            }
            }
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
                    
                    MapPolyline(coordinates: viewModel.polylineCoordinates)
                        .stroke(.green02, lineWidth: 5)
                }
                .onAppear {
                    isMapInitialized = true
                }
                .onMapCameraChange { context in
                    viewModel.visibleRegion = context.region
                    
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
    
    // 이 지역 검색 버튼
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
    
    // 길찾기 뷰
    private var directionsView: some View {
        func convertCoordinate(from string: String) -> CLLocationCoordinate2D? {
            let parts = string.split(separator: ",")
            guard parts.count == 2,
                  let lon = Double(parts[0]),
                  let lat = Double(parts[1]) else {
                return nil
            }
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        
        return VStack(spacing: 18) {
            searchFilterView
            
            Button(action: {
                print("경로 찾기")
                Task {
                    isLoadingRoute = true
                    await viewModel.getDirections()
                    isLoadingRoute = false
                    
                    if let coord = convertCoordinate(from: viewModel.originCoordinate ?? "") {
                        viewModel.cameraPosition = .camera(MapCamera(centerCoordinate: coord, distance: 2000))
                    }
                    
                    selectedSegment = .first
                }
            }, label: {
                Text("경로 찾기")
                    .font(.pretendardMedium(16))
                    .foregroundStyle(.white)
                    .frame(maxWidth: 375, maxHeight: 38)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.green01)
                    )
            })
            
            placeListView
        }
    }
    
    // 출발
    private var originView: some View {
        HStack(spacing: 15) {
            Text("출발")
                .font(.pretendardSemiBold(16))
                .foregroundStyle(.gray12)
            
            HStack(spacing: 8) {
                Button(action: {
                    print("현재 위치")
                    Task {
                        await viewModel.updateCurrentAddress()
                    }
                }, label: {
                    Text("현재 위치")
                        .font(.pretendardSemiBold(13))
                        .foregroundStyle(.white01)
                        .frame(maxWidth: 58, maxHeight: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.brown01)
                        )
                })
                
                TextField("출발지 입력", text: $viewModel.origin)
                    .font(.pretendardRegular(13))
                    .foregroundStyle(.black03)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 7)
                    .background (
                        Rectangle()
                            .stroke(.gray03, lineWidth: 1)
                    )
                
                Button(action: {
                    Task {
                        await viewModel.getSearch()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                })
            }
        }
        .alert("검색 결과가 존재하지 않습니다.", isPresented: $viewModel.showOriginNoResultsAlert) {
            Button("확인", role: .cancel) { }
        }
    }
    
    // 도착
    private var destinationView: some View {
        HStack(spacing: 15) {
            Text("도착")
                .font(.pretendardSemiBold(16))
                .foregroundStyle(.gray12)
            
            HStack(spacing: 8) {
                TextField("매장명 또는 주소", text: $viewModel.destination)
                    .font(.pretendardRegular(13))
                    .foregroundStyle(.black03)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 7)
                    .background (
                        Rectangle()
                            .stroke(.gray03, lineWidth: 1)
                    )
                
                Button(action: {
                    print("목적지 검색")
                    viewModel.getDestinationSearch()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                })
            }
        }
        .alert("해당 검색어로 조회된 매장정보가 존재하지 않습니다.", isPresented: $viewModel.showDestinationNoResultsAlert) {
            Button("확인", role: .cancel) { }
        }
    }
    
    // 상단 검색 필터들
    private var searchFilterView: some View {
        VStack(spacing: 13) {
            originView
            
            destinationView
        }
        .frame(maxWidth: 375)
    }
    
    // 장소 리스트뷰
    private var placeListView: some View {
        ScrollView(.vertical, content: {
            LazyVStack(spacing: 28, content: {
                if let places = viewModel.searchResults {
                    ForEach(places.indices, id: \.self) { index in
                        PlaceList(model: places[index])
                            .padding(.top, index == 0 ? 10 : 0)
                            .onTapGesture {
                                viewModel.clickPlaceList(place: places[index])
                            }
                    }
                }
            })
        })
    }
}

#Preview {
    FindStoreView()
        .environment(NavigationRouter())
}

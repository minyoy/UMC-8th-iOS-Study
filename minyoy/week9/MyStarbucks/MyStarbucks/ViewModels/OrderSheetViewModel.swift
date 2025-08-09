//
//  OrderSheetViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/11/25.
//

import SwiftUI
import MapKit
import Observation
import Moya

@Observable
class OrderSheetViewModel {
    //MARK: - 길찾기
    // 출발/도착 텍스트필드 값
    var origin: String = ""
    var destination: String = ""
    
    var isOrigin = true
    var originCoordinate: String?
    var destinationCoordinate: String?
    
    // 출발지 검색 결과가 없을 때 Alert를 띄우게
    var showOriginNoResultsAlert = false
    // 목적지 검색 결과가 없을 때 Alert를 띄우게
    var showDestinationNoResultsAlert = false
    
    // 길찾기 경로
    var polylineCoordinates: [CLLocationCoordinate2D] = []
    
    var searchResults: [KakaoPlace]?
    
    let provider: MoyaProvider<PlaceRouter>
    
    init(provider: MoyaProvider<PlaceRouter> = APIManager.shared.createProvider(for: PlaceRouter.self)) {
        self.provider = provider
    }
    
//    init(provider: MoyaProvider<PlaceRouter> = APIManager.shared.testProvider(for: PlaceRouter.self)) {
//        self.provider = provider
//    }
    
    // 출발지 검색
    func getSearch() async {
        do {
            let response = try await provider.requestAsync(.getKakaoPlaceSearch(query: self.origin))
            let place = try JSONDecoder().decode(KakaoPlacesResponse.self, from: response.data)
            self.searchResults = place.documents
            self.isOrigin = true
            
            if place.documents.isEmpty {
                self.showOriginNoResultsAlert = true
            }
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
        }
    }
    
    // 목적지를 현재위치 주소로 변경
    func updateCurrentAddress() async {
        if let location = location.currentLocation {
            let geocoder = CLGeocoder()
            
            do {
                let placemarks = try await geocoder.reverseGeocodeLocation(location)
                if let placemark = placemarks.first {
                    let address = [
                        placemark.administrativeArea,
                        placemark.subAdministrativeArea,
                        placemark.name,
                    ].compactMap { $0 }.joined(separator: " ")

                    print("주소: \(address)")
                    
                    origin = address
                    
                    let longitude = location.coordinate.longitude
                    let latitude = location.coordinate.latitude
                    originCoordinate = "\(longitude),\(latitude)"
                }
            } catch {
                print("역지오코딩 에러: \(error.localizedDescription)")
            }
        }
    }
    
    // PlaceList 클릭 시, 텍스트필드 값을 placeName으로 변경 후 검색 결과 리스트 초기화
    func clickPlaceList(place: KakaoPlace) {
        if (self.isOrigin) {
            origin = place.place_name
            originCoordinate = "\(place.x),\(place.y)"
        } else {
            destination = place.place_name
            destinationCoordinate = "\(place.x),\(place.y)"
        }
        searchResults?.removeAll()
    }
    
    // 목적지 검색
    func getDestinationSearch() {
        guard let url = Bundle.main.url(forResource: "Starbucks_2025_store_data", withExtension: "geojson") else {
            print("geojson 파일 없음")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(StoreResponse.self, from: data)

            let rawStores = decoded.features.map { $0.properties }
            let normalizedKeyword = destination.lowercased().replacingOccurrences(of: " ", with: "")

            // store_nm 정확히 일치
            let exactMatches = rawStores.filter {
                $0.Sotre_nm.lowercased().replacingOccurrences(of: " ", with: "") == normalizedKeyword
            }
            
            // store_nm 정확히 일치하는게 있다면
            if !exactMatches.isEmpty {
                self.searchResults = exactMatches.map {
                    KakaoPlace(address_name: $0.Address, place_name: $0.Sotre_nm, x: "\($0.Xcoordinate)", y: "\($0.Ycoordinate)")
                }
            } else { // store_nm 정확히 일치하는게 없다면 주소에 키워드를 포함하고 있는 애들로
                let partialMatches = rawStores.filter {
                    $0.Address.lowercased().contains(normalizedKeyword)
                }

                self.searchResults = partialMatches.map {
                    KakaoPlace(address_name: $0.Address, place_name: $0.Sotre_nm, x: "\($0.Xcoordinate)", y: "\($0.Ycoordinate)")
                }
            }
            
            self.isOrigin = false
            
            if self.searchResults?.isEmpty ?? true {
                self.showDestinationNoResultsAlert = true
            }

            print("디코딩 및 검색 성공")

        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
        }
    }
    
    // 경로 찾기
    func getDirections() async {
        do {
            guard let originCoord = originCoordinate, let destinationCoord = destinationCoordinate else {
                print("좌표가 설정되지 않음")
                return
            }
            
            let response = try await provider.requestAsync(
                .getDirections(
                    origin: originCoord,
                    destination: destinationCoord
                )
            )
            let route = try JSONDecoder().decode(RouteResponse.self, from: response.data)
            let rawCoordinates = route.routes[0].geometry.coordinates
            self.polylineCoordinates = rawCoordinates.map {
                CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
            }
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
        }
    }
    
    //MARK: - 매장찾기
    var searchKeyword: String = ""
    var selectedSegment: OrderSheetSegment = .first
    var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.550952, longitude: 126.925479),
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
    )
//    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var visibleRegion: MKCoordinateRegion?
    var location = LocationManager.shared
    
    var allStores: [StoreFeature]?
    var stores: [StoreFeature]?
    var pinStores: [StoreFeature]?
    
    func loadStores() {
        guard let url = Bundle.main.url(forResource: "Starbucks_2025_store_data", withExtension: "geojson") else {
            print("geojson 파일 없음")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(StoreResponse.self, from: data)

            self.allStores = decoded.features
            self.stores = decoded.features
            print("디코딩 성공")
        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
        }
    }
    
    func calculateDistanceFromCurrentLocation() async {
        guard let current = location.currentLocation else {
            print("현재 위치없음")
            return
        }
        guard let allStores = self.allStores else {
            print("allstores 없음")
            return
        }
        
        let myLocation = CLLocation(
            latitude: current.coordinate.latitude,
            longitude: current.coordinate.longitude
        )
        
        await MainActor.run {
            self.stores = allStores.compactMap { store in
                let storeLocation = CLLocation(
                    latitude: store.properties.Ycoordinate,
                    longitude: store.properties.Xcoordinate
                )
                
                let distance = myLocation.distance(from: storeLocation) / 1000
                
                // 10km 초과는 제거
                guard distance <= 10 else { return nil }
                
                var updated = store
                updated.properties.KM = round(distance * 10) / 10
                return updated
            }
            self.pinStores = stores
            
            guard let stores = self.stores else { return }
            var updatedStores: [StoreFeature] = []
            
            for store in stores {
                var updated = store
                let category = store.properties.Category
                
                // 매장 카테고리 분류
                switch category {
                case "DTR 매장":
                    updated.properties.storeCategory = .dtr
                case "리저브 매장":
                    updated.properties.storeCategory = .reserve
                case "DT 매장":
                    updated.properties.storeCategory = .dt
                default:
                    break
                }
                
                updatedStores.append(updated)
            }
            
            let sortedStores = updatedStores.sorted {
                let loc1 = CLLocation(
                    latitude: $0.properties.Ycoordinate,
                    longitude: $0.properties.Xcoordinate
                )
                let loc2 = CLLocation(
                    latitude: $1.properties.Ycoordinate,
                    longitude: $1.properties.Xcoordinate
                )
                
                return myLocation.distance(from: loc1) < myLocation.distance(from: loc2)
            }
            self.stores = sortedStores
        }
    }
    
    func calculateDistanceFromRegionCenter() {
        guard let allStores = self.allStores else { return }
        guard let base = visibleRegion?.center else { return }
        
        let cameraLocation = CLLocation(latitude: base.latitude, longitude: base.longitude)

        self.pinStores = allStores.compactMap { store in
            let storeLocation = CLLocation(
                latitude: store.properties.Ycoordinate,
                longitude: store.properties.Xcoordinate
            )
            let distance = cameraLocation.distance(from: storeLocation) / 1000
            guard distance <= 10 else { return nil }
            return store
        }
    }
    
    // FIX-ME:-
    func calculateReverseGeocoder(location: CLLocation) async -> String {
        let geocoder = CLGeocoder()
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let address = [
                    placemark.administrativeArea,
                    placemark.subAdministrativeArea,
                    placemark.name,
                ].compactMap { $0 }.joined(separator: " ")

                print("주소: \(address)")
                return address
            }
        } catch {
            print("역지오코딩 에러: \(error.localizedDescription)")
        }
        return "주소 없음"
    }
}

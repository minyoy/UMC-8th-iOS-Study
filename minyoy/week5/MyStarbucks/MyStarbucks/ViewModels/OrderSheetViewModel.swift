//
//  OrderSheetViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/11/25.
//

import SwiftUI
import MapKit
import Observation

@Observable
class OrderSheetViewModel {
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
    func calculateGeocoder(location: CLLocation) async -> String {
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

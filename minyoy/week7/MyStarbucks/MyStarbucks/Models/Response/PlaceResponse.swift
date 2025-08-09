//
//  PlaceResponse.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/18/25.
//

struct GooglePlacesResponse: Codable {
    let results: [GooglePlace]
}

struct GooglePlace: Codable {
    let photos: [GooglePlacePhoto]
}

struct GooglePlacePhoto: Codable {
    let photo_reference: String
}


struct KakaoPlacesResponse: Codable {
    let documents: [KakaoPlace]
}

struct KakaoPlace: Codable {
    let address_name: String
    let place_name: String
    let x: String
    let y: String
}


struct RouteResponse: Codable {
    let routes: [GeometryRoute]
}

struct GeometryRoute: Codable {
    let geometry: Geometry
}

struct Geometry: Codable {
    let coordinates: [[Double]]
}

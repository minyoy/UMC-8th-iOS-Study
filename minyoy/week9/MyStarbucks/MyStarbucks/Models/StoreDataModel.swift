//
//  StoreDataModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/11/25.
//

import Foundation
    
struct StoreResponse: Codable {
    let type: String
    let name: String
    let features: [StoreFeature]
}
    
struct StoreFeature: Codable {
    let type: String
    var properties: StorePropertie
    let geometry: StoreGeometry
}
    
struct StorePropertie: Codable {
    let Seq: String
    let Sotre_nm: String
    var Address: String
    let Telephone: String
    let Category: String
    let Ycoordinate: Double
    let Xcoordinate: Double
    
    var KM: Double? = nil
    var storeCategory: StoreCategory? = nil
}

enum StoreCategory: Codable {
    case dtr
    case reserve
    case dt
}
    
struct StoreGeometry: Codable {
    let type: String
    let coordinates: [Double]
}

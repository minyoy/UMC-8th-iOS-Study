//
//  CoffeeModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import Foundation
import SwiftUI

struct CoffeeModel: Identifiable, MenuDisplayable {
    let id = UUID()
    var name: String
    var nameEn: String
    var image: Image
    var content: String
    var price: String
    var temperature: CoffeeTemp
    var hasBothTemps: Bool
}

enum CoffeeTemp: CaseIterable {
    case hot
    case iced
}
//
//struct CoffeeModel: Identifiable, MenuDisplayable {
//    let id = UUID()
//    var name: String
//    var image: Image
//}

//
//  CardModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 6/17/25.
//

import SwiftData
import SwiftUI

@Model
class Card {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var price: Int
    var num: String
    var image: Data
    var createdAt: Date

    init(name: String, price: Int, num: String, image: UIImage, createdAt: Date = .now) {
        self.name = name
        self.price = price
        self.num = num
        self.image = image.jpegData(compressionQuality: 1.0) ?? Data()
        self.createdAt = createdAt
    }
}

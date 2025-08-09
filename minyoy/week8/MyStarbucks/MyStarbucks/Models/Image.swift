//
//  Image.swift
//  MyStarbucks
//
//  Created by 주민영 on 6/17/25.
//

import SwiftUI

struct ImageModel: Identifiable {
    var id: UUID = .init()
    var image: String
}

var images: [ImageModel] = (1...4).compactMap({ ImageModel(image: "Card\($0)")})

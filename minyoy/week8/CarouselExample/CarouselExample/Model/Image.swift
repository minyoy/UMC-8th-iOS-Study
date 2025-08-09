//
//  Image.swift
//  CarouselExample
//
//  Created by 주민영 on 6/17/25.
//

import SwiftUI

struct ImageModel: Identifiable {
    var id: UUID = .init()
    var image: String
}

var images: [ImageModel] = (1...8).compactMap({ ImageModel(image: "Image\($0)")})

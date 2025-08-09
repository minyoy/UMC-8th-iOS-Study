//
//  Txt2ImgImageOnlyResponse.swift
//  TestAlamofire
//
//  Created by Apple Coding machine on 5/3/25.
//

import Foundation

struct Txt2ImgImageOnlyResponse: Codable {
    let images: [String]
}

struct Txt2ImgProgressOnlyResponse: Codable {
    let progress: Double
}

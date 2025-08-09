//
//  ProductModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/5/25.
//

import Foundation
import SwiftUI

struct ProductModel: Identifiable {
    let id = UUID()
    var image: Image
    var name: String
}

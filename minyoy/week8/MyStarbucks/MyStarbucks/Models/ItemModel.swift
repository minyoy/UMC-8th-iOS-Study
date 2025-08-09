//
//  BestItemModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/5/25.
//

import Foundation
import SwiftUI

struct ItemModel: Identifiable {
    let id = UUID()
    var image: Image
    var name: String
    var volume: Int?
}

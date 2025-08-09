//
//  DessertModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import Foundation
import SwiftUI

struct DessertModel: Identifiable, MenuDisplayable {
    let id = UUID()
    var image: Image
    var name: String
}

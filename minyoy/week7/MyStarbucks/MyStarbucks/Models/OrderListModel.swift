//
//  OrderListModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/10/25.
//

import Foundation
import SwiftUI

struct OrderListModel: Identifiable {
    let id = UUID()
    var image: Image
    var title: String
    var titleEn: String
}

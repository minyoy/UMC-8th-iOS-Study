//
//  NewsModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import Foundation
import SwiftUI

struct NewsModel: Identifiable {
    let id = UUID()
    var image: Image
    var title: String
    var subtitle: String
}

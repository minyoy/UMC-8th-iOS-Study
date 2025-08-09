//
//  CategorySegment.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/10/25.
//

import Foundation

enum CategorySegment: Int, CaseIterable, Identifiable {
    case first
    case second
    case third
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .first:
            return "음료"
        case .second:
            return "푸드"
        case .third:
            return "상품"
        }
    }
}

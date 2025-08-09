//
//  FindStoreSegment.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/11/25.
//

import Foundation

enum FindStoreSegment: Int, CaseIterable, Identifiable {
    case first
    case second
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .first:
            return "매장 찾기"
        case .second:
            return "길찾기"
        }
    }
}

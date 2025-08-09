//
//  OrderSegment.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/10/25.
//

import Foundation

enum OrderSegment: Int, CaseIterable, Identifiable {
    case first
    case second
    case third
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .first:
            return "전체 메뉴"
        case .second:
            return "나만의 메뉴"
        case .third:
            return "홀케이크 예약"
        }
    }
}

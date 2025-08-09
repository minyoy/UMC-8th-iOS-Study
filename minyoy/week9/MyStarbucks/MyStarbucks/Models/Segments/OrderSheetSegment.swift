//
//  OrderSheetSegment.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/11/25.
//

import Foundation

enum OrderSheetSegment: Int, CaseIterable, Identifiable {
    case first
    case second
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .first:
            return "가까운 매장"
        case .second:
            return "자주 가는 매장"
        }
    }
}

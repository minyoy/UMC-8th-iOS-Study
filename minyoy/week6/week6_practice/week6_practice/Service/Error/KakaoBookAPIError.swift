//
//  KakaoBookAPIError.swift
//  week6_practice
//
//  Created by 주민영 on 5/12/25.
//

import Foundation

enum KakaoBookAPIError: Error, LocalizedError {
    case invalidResponse
    case noResult
    case network(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "유효하지 않은 응답"
        case .noResult:
            return "검색 결과 존재하지 않아요"
        case .network(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        }
    }
}

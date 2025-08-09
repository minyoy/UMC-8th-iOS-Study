//
//  TokenResponse.swift
//  week7_practice
//
//  Created by 주민영 on 5/17/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}

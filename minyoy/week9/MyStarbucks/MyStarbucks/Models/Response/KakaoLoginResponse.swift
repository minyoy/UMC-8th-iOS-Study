//
//  KakaoLoginResponse.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/12/25.
//

import Foundation

struct KakaoCodeResponse: Codable {
    let code: String?
}

struct KakaoLoginResponse: Codable {
    let tokenType: String
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String
    let refreshTokenExpiresIn: Int
    let scope: String?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
        case scope
    }
}

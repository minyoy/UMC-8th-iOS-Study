//
//  TokenProviding.swift
//  week7_practice
//
//  Created by 주민영 on 5/17/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}

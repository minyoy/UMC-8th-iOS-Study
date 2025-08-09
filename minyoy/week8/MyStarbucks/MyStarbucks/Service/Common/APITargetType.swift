//
//  APITargetType.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/18/25.
//

import Foundation
import Moya

protocol APITargetType: TargetType {}

extension APITargetType {

    var headers: [String: String]? {
        switch task {
        case .requestJSONEncodable, .requestParameters:
            return ["Content-Type": "application/json"]
        case .uploadMultipart:
            return ["Content-Type": "multipart/form-data"]
        default:
            return nil
        }
    }
    
    var validationType: ValidationType { .successCodes }
}

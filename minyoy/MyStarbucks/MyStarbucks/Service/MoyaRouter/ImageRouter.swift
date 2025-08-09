//
//  ImageRouter.swift
//  MyStarbucks
//
//  Created by 주민영 on 6/17/25.
//

import Moya
import SwiftUI

enum ImageRouter {
    case postTxt2Img(request: Txt2ImgRequest)
    case getProgress
}

extension ImageRouter: APITargetType {
    
    var baseURL: URL {
        switch self {
        case .postTxt2Img, .getProgress:
            return URL(string: "\(Config.imageURL)")!
        }
    }
    
    var path: String {
        switch self {
        case .postTxt2Img:
            return "/sdapi/v1/txt2img"
        case .getProgress:
            return "/sdapi/v1/progress"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postTxt2Img:
            return .post
        case .getProgress:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .postTxt2Img(let request):
            return .requestJSONEncodable(request)
        case .getProgress:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .postTxt2Img, .getProgress:
            return ["Content-Type": "application/json"]
        }
    }
}

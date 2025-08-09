//
//  Config.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/12/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let restApiKey: String = {
        guard let restApiKey = Config.infoDictionary["REST_API_KEY"] as? String else {
            fatalError()
        }
        return restApiKey
    }()
    
    static let nativeAppKey: String = {
        guard let nativeAppKey = Config.infoDictionary["NATIVE_APP_KEY"] as? String else {
            fatalError()
        }
        return nativeAppKey
    }()
    
    static let googleApiURL: String = {
        guard let googleApiURL = Config.infoDictionary["GOOGLE_API_URL"] as? String else {
            fatalError()
        }
        return googleApiURL
    }()
    
    static let kakaoApiURL: String = {
        guard let kakaoApiURL = Config.infoDictionary["KAKAO_API_URL"] as? String else {
            fatalError()
        }
        return kakaoApiURL
    }()
    
    static let destinationApiURL: String = {
        guard let destinationApiURL = Config.infoDictionary["DESTINATION_API_URL"] as? String else {
            fatalError()
        }
        return destinationApiURL
    }()
    
    static let apiKey: String = {
        guard let apiKey = Config.infoDictionary["API_KEY"] as? String else {
            fatalError()
        }
        return apiKey
    }()
}

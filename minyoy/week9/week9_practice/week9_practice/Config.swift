//
//  Config.swift
//  week9_practice
//
//  Created by 주민영 on 6/18/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let serviceKey: String = {
        guard let serviceKey = Config.infoDictionary["SERVICE_KEY"] as? String else {
            fatalError()
        }
        return serviceKey
    }()
}

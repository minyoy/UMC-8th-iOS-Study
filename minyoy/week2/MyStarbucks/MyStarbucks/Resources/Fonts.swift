//
//  Fonts.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/19/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var PretendardExtraBold24: Font {
        return .pretend(type: .extraBold, size: 24)
    }
    
    static var PretendardMedium18: Font {
        return .pretend(type: .medium, size: 18)
    }
    
    static var PretendardMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var PretendardRegular18: Font {
        return .pretend(type: .regular, size: 18)
    }
    
    static var PretendardRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var PretendardRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static func pretendardBold(_ size: CGFloat) -> Font {
        return .pretend(type: .bold, size: size)
    }
    
    static func pretendardSemiBold(_ size: CGFloat) -> Font {
        return .pretend(type: .semibold, size: size)
    }
    
    static func PretendardLight(_ size: CGFloat) -> Font {
        return .pretend(type: .light, size: size)
    }
}

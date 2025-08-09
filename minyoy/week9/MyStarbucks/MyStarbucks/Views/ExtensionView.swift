//
//  ExtensionView.swift
//  MyStarbucks
//
//  Created by 주민영 on 6/18/25.
//

import Foundation
import SwiftUI

extension View {
    func getScreenSize() -> CGSize {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return windowScene.screen.bounds.size
    }
}

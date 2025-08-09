//
//  LoginViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/19/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var loginModel: LoginModel = .init(email: "minyoy", pwd: "example")
}

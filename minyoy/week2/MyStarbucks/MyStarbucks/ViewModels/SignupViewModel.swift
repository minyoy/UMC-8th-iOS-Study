//
//  SignupViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/24/25.
//

import Foundation
import SwiftUI

class SignupViewModel: ObservableObject {
    @AppStorage("nickname") private var nickname: String = ""
    @AppStorage("email") private var email: String = ""
    @AppStorage("pwd") private var pwd: String = ""
    
    @Published var signupModel: SignupModel = .init(nickname: "minyoy", email: "minyoy@example.com", pwd: "example")
    
    /// 현재 정보를 AppStorage에 저장
    public func saveAppStorage() {
        print("성공적으로 appStorage에 저장되었습니다!")
        self.nickname = signupModel.nickname
        self.email = signupModel.email
        self.pwd = signupModel.pwd
    }
}

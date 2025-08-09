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
    
    @Published var signupModel: SignupModel = .init(nickname: "", email: "", pwd: "")
    
    let keychain = KeychainService.shared
    
    /// 현재 정보를 AppStorage에 저장
    public func saveAppStorage() {
        print("성공적으로 appStorage에 저장되었습니다!")
        self.nickname = signupModel.nickname
        self.email = signupModel.email
        self.pwd = signupModel.pwd
    }
    
    /// 현재 정보를 Keychain에 저장
    public func saveKeychain() {
        print("성공적으로 Keychain에 저장되었습니다!")
        let userInfo = UserInfo(
            email: signupModel.email,
            password: signupModel.pwd,
            nickname: signupModel.nickname
        )
        
        keychain.save(userInfo: userInfo)
    }
}

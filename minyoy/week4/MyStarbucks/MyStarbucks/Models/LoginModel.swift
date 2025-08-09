//
//  LoginModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/19/25.
//

import Foundation

struct LoginModel {
    var email: String
    var pwd: String
    
    mutating func editEmail(email: String) {
        self.email = email
    }
    
    mutating func editPwd(pwd: String) {
        self.pwd = pwd
    }
}

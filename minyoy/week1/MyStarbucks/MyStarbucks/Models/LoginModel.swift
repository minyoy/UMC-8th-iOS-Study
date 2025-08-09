//
//  LoginModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/19/25.
//

import Foundation

struct LoginModel {
    var id: String
    var pwd: String
    
    mutating func editId(id: String) {
        self.id = id
    }
    
    mutating func editPwd(pwd: String) {
        self.pwd = pwd
    }
}

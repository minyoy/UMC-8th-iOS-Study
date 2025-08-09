//
//  SignupView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/24/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject var viewModel: SignupViewModel = .init()
    
    var body: some View {
        VStack {
            middleView
            
            Spacer()
            
            Button(action: {
                viewModel.saveAppStorage()
            }, label: {
                Text("생성하기")
                    .font(.PretendardMedium18)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 402, maxHeight: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green01)
                    )
            })
        }
        .padding(.top, 210)
        .padding(.horizontal, 19)
    }
    
    private var middleView: some View {
        VStack(alignment: .leading, spacing: 49) {
            TextField("닉네임", text: $viewModel.signupModel.nickname)
                .font(.PretendardRegular18)
                .foregroundStyle(.black01)
                .autocapitalization(.none)
                .overlay(alignment: .bottom, content: {
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray00)
                        .offset(x: 0, y: 9)
                })
            
            TextField("이메일", text: $viewModel.signupModel.email)
                .font(.PretendardRegular18)
                .foregroundStyle(.black01)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .overlay(alignment: .bottom) {
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray00)
                        .offset(x: 0, y: 9)
                }
            
            TextField("비밀번호", text: $viewModel.signupModel.pwd)
                .font(.PretendardRegular18)
                .foregroundStyle(.black01)
                .autocapitalization(.none)
                .overlay(alignment: .bottom) {
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray00)
                        .offset(x: 0, y: 9)
                }
        }
    }
}

#Preview {
    SignupView()
}

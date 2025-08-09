//
//  SignupView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/24/25.
//

import SwiftUI

struct SignupView: View {
    @Environment(NavigationRouter.self) private var router
    
    @StateObject var viewModel: SignupViewModel = .init()
    
    var body: some View {
        VStack {
            CustomNavBar(title: "가입하기", onBack: {
                router.pop()
            })
            
            Spacer()
            
            VStack {
                middleView
                
                Spacer()
                
                Button(action: {
                    if !viewModel.signupModel.nickname.isEmpty,
                       !viewModel.signupModel.email.isEmpty,
                       !viewModel.signupModel.pwd.isEmpty {
                        viewModel.saveAppStorage()
                        router.pop()
                    } else {
                        print("모든 값을 한 글자 이상 입력해주세요!")
                    }
                }, label: {
                    Text("생성하기")
                        .font(.pretendardMedium(18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: 402, maxHeight: 58)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.green01)
                        )
                })
            }
            .padding(.top, 130)
            .padding(.horizontal, 19)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private var middleView: some View {
        VStack(alignment: .leading, spacing: 49) {
            TextField("닉네임", text: $viewModel.signupModel.nickname)
                .font(.pretendardRegular(18))
                .foregroundStyle(.black01)
                .autocapitalization(.none)
                .overlay(alignment: .bottom, content: {
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray00)
                        .offset(x: 0, y: 9)
                })
            
            TextField("이메일", text: $viewModel.signupModel.email)
                .font(.pretendardRegular(18))
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
                .font(.pretendardRegular(18))
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
        .environment(NavigationRouter())
}

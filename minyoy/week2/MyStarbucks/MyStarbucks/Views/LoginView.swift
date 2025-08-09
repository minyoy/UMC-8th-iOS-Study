//
//  LoginView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/19/25.
//

import SwiftUI

struct LoginView: View {
    enum LoginField {
        case id
        case pwd
    }
    @StateObject var viewModel: LoginViewModel = .init()
    @FocusState private var focusedField: LoginField?
    
    var body: some View {
        VStack {
            topGroup
            
            Spacer()
            
            middleGroup
            
            Spacer()
            
            bottomGroup
        }
        .padding(.horizontal, 19)
    }
    
    private var topGroup: some View {
        VStack(alignment: .leading) {
            Image(.starbucks)
                .resizable()
                .frame(width: 97, height: 95)
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Text("안녕하세요.\n스타벅스입니다.")
                    .font(.PretendardExtraBold24)
                    .kerning(2)
                Spacer()
            }
            .frame(height: 58)
            .padding(.top, 28)
            
            HStack {
                Text("회원 서비스 이용을 위해 로그인 해주세요.")
                    .font(.PretendardMedium16)
                    .foregroundStyle(.gray01)
                    .kerning(-0.8)
                Spacer()
            }
            .padding(.top, 19)
        }
        .padding(.top, 104)
    }
    
    private var middleGroup: some View {
        VStack(alignment: .leading, spacing: 47) {
            TextField("이메일", text: $viewModel.loginModel.email)
                .font(.PretendardRegular13)
                .foregroundStyle(.black01)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .focused($focusedField, equals: .id)
                .overlay(alignment: .bottom) {
                    Divider()
                        .frame(height: 1)
                        .background(focusedField == .id ? Color.green01 : Color.gray00)
                        .padding(.top, 2)
                }
            
            SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                .font(.PretendardRegular13)
                .foregroundStyle(.black01)
                .autocapitalization(.none)
                .focused($focusedField, equals: .pwd)
                .overlay(alignment: .bottom) {
                    Divider()
                        .frame(height: 1)
                        .background(focusedField == .pwd ? Color.green01 : Color.gray00)
                        .padding(.top, 2)
                }
            
            Button(action: {
                print("로컬 로그인 버튼")
            }, label: {
                Text("로그인하기")
                    .font(.PretendardMedium16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 402, maxHeight: 46)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green01)
                    )
            })
        }
    }
    
    private var bottomGroup: some View {
        VStack(alignment: .center, spacing: 19) {
            Text("이메일로 회원가입하기")
                .foregroundStyle(.gray03)
                .font(.PretendardRegular12)
                .underline()
            
            Image(.kakaoLogin)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 45)
            
            Image(.appleLogin)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 45)
        }
    }
}

struct SwiftUIView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

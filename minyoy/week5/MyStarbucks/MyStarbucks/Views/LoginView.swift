//
//  LoginView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/19/25.
//

import SwiftUI

enum LoginField {
    case id
    case pwd
}

struct LoginView: View {
    @Environment(NavigationRouter.self) private var router
    
    @StateObject var viewModel: LoginViewModel = .init()
    
    @AppStorage("email") var savedEmail: String = ""
    @AppStorage("pwd") var savedPassword: String = ""
    
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
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private var topGroup: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(.starbucks)
                    .resizable()
                    .frame(width: 97, height: 95)
                    .aspectRatio(contentMode: .fit)
            
                Text("안녕하세요.\n스타벅스입니다.")
                    .font(.PretendardExtraBold(24))
                    .kerning(2)
                    .frame(height: 58)
                    .padding(.top, 28)
                
                Text("회원 서비스 이용을 위해 로그인 해주세요.")
                    .font(.pretendardMedium(16))
                    .foregroundStyle(.gray01)
                    .kerning(-0.8)
                    .padding(.top, 19)
            }
            
            Spacer()
        }
        .padding(.top, 104)
    }
    
    private var middleGroup: some View {
        VStack(alignment: .leading, spacing: 47) {
            TextField("이메일", text: $viewModel.loginModel.email)
                .font(.pretendardRegular(13))
                .foregroundStyle(.black01)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .id)
                .overlay(alignment: .bottom) {
                    Divider()
                        .frame(height: 1)
                        .background(focusedField == .id ? Color.green01 : Color.gray00)
                        .padding(.top, 2)
                }
            
            SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                .font(.pretendardRegular(13))
                .foregroundStyle(.black01)
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .pwd)
                .overlay(alignment: .bottom) {
                    Divider()
                        .frame(height: 1)
                        .background(focusedField == .pwd ? Color.green01 : Color.gray00)
                        .padding(.top, 2)
                }
            
            Button(action: {
                print("로컬 로그인 버튼")
                if viewModel.loginModel.email == savedEmail &&
                    viewModel.loginModel.pwd == savedPassword {
                    
                    print("성공적으로 로그인되었습니다!")
                    
                    router.reset()
                    router.push(.baseTab)
                } else {
                    print("이메일과 패스워드가 다릅니다.")
                }
            }, label: {
                Text("로그인하기")
                    .font(.pretendardMedium(16))
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
            Button(action: {
                router.push(.signup)
            }, label: {
                Text("이메일로 회원가입하기")
                    .foregroundStyle(.gray03)
                    .font(.pretendardRegular(12))
                    .underline()
            })
            
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
                .environment(NavigationRouter())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

//
//  ContentView.swift
//  week7_practice
//
//  Created by 주민영 on 5/17/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var combineViewModel: CombineViewModel = .init()
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button(action: {
                    button.action()
                }, label: {
                    Text(button.title)
                })
            }
            
            Divider()
                .frame(height: 2)
            
            TextField(text: $combineViewModel.userName, label: {
                Text("유저 이름을 입력해주세요!")
            })
        }
        .padding()
    }
}

struct ButtonInfo: Identifiable {
    var id: UUID = .init()
    var title: String
    var action: () -> Void
}

final class ButtonInfoList {
    
    static let serviceManager: ContentsViewModel = .init()
    
    static let buttonList: [ButtonInfo] = [
        .init(title: "로그인", action: {
            serviceManager.loginAndStoreTokens()
        }),
        .init(title: "GET", action: {
            Task {
                await serviceManager.getUser()
            }
        }),
        .init(title: "POST", action: {
            serviceManager.createUser(.init(name: "야옹제옹냐옹", age: 29, address: "포항시 대잠동", height: 177))
        }),
        .init(title: "PATCH", action: {
            serviceManager.updateUserPatch(.init(name: nil, age: 18, address: nil, height: nil))
        }),
        .init(title: "PUT", action: {
            serviceManager.updateUserPut(.init(name: "JeOng", age: 29, address: "서울시", height: 177))
        }),
        .init(title: "DELETE", action: {
            serviceManager.deleteUser(name: "JeOng")
        }),
    ]
}

#Preview {
    ContentView()
}

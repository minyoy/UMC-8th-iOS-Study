//
//  ContentView.swift
//  TestAlamofire
//
//  Created by 주민영 on 5/11/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button(action: {
                    button.action()
                }, label: {
                    Text(button.title)
                })
            }
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
    
    static let serviceManager: ServiceManager = .init()
    
    static let buttonList: [ButtonInfo] = [
        .init(title: "GET", action: {
            Task {
                await serviceManager.getUser(name: "제옹")
            }
        }),
        .init(title: "POST", action: {
            Task {
                await serviceManager.postUser(user: .init(name: "제옹", age: 29, address: "포항시 대잠동", height: 177))
                
            }
        }),
        .init(title: "PATCH", action: {
            Task {
                await serviceManager.patchUser(name: "Je-Ong")
            }
        }),
        .init(title: "PUT", action: {
            Task {
                await serviceManager.putUser(user: .init(name: "제옹", age: 20, address: "경기도 수원시", height: 190))
            }
        }),
        .init(title: "DELETE", action: {
            Task {
                await serviceManager.deleteUser(name: "제옹")
            }
        }),
    ]
}

#Preview {
    ContentView()
}


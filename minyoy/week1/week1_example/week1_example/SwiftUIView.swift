//
//  SwiftUIView.swift
//  week1_example
//
//  Created by 주민영 on 3/18/25.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            headerView
            messageView
            actionButton
        }
    }
    
    private var headerView: some View {
        Text("hello swiftUI")
            .font(.title)
            .foregroundStyle(Color.red)
    }
    
    private var messageView: some View {
        Text("이제 하위 뷰를 만들어보자")
            .font(.title)
            .foregroundStyle(Color.gray)
    }
    
    private var actionButton: some View {
        Button(action: {
            print("버튼 눌렸네요 ㅎㅎ")
        }, label: {
            Text("클릭해보세요!")
        })
    }
}

#Preview {
    SwiftUIView()
}

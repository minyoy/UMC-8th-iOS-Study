//
//  listItem.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/25/25.
//

import SwiftUI

struct listItem: View {
    let icon: Image
    let content: String
    let action: () -> Void
    
    init(icon: Image, content: String, action: @escaping () -> Void = {}) {
        self.icon = icon
        self.content = content
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            print(content)
            action()
        }, label: {
            HStack(spacing: 6) {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 26, maxHeight: 26)
                Text(content)
                    .font(.pretendardSemiBold(16))
                
                Spacer()
            }
            .foregroundStyle(.black)
        })
        .frame(width: 180, height: 32)
    }
}

#Preview {
    listItem(icon: Image("icon 1"), content: "쿠폰 등록")
}

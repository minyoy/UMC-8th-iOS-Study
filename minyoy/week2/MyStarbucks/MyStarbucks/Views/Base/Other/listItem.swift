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
    
    init(icon: Image, content: String) {
        self.icon = icon
        self.content = content
    }
    
    var body: some View {
        Button(action: {
            print(content)
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

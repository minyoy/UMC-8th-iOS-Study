//
//  CustomNavBar.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import SwiftUI

struct CustomNavBar: View {
    let title: String
    let onBack: (() -> Void)
        
    init(title: String, onBack: @escaping (() -> Void)) {
        self.title = title
        self.onBack = onBack
    }
    
    var body: some View {
        HStack {
            Button(action : {
                onBack()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            Text(title)
                .font(.pretendardMedium(16))
            
            Spacer()
            
            Rectangle()
                .fill(.clear)
                .frame(width: 24, height: 24)
        }
        .padding()
    }
}

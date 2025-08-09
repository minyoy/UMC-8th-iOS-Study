//
//  HotIcedToggle.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import SwiftUI

struct HotIcedToggle: View {
    let temp: CoffeeTemp

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.gray07)
                .frame(height: 36)
            
            HStack(spacing: 0) {
                Text("HOT")
                    .font(.pretendardSemiBold(18))
                    .foregroundColor(temp == .hot ? .red01.opacity(0.6) : .gray02)
                    .frame(maxWidth: .infinity, minHeight: 36)
                    .background {
                        Rectangle()
                            .fill(temp == .hot ? Color.white : Color.clear)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 1)
                    }
                
                Text("ICED")
                    .font(.pretendardSemiBold(18))
                    .foregroundColor(!(temp == .hot) ? .blue01.opacity(0.6) : .gray02)
                    .frame(maxWidth: .infinity, minHeight: 36)
                    .background {
                        Rectangle()
                            .fill(!(temp == .hot) ? Color.white : Color.clear)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 1)
                    }
            }
        }
    }
}


#Preview {
    HotIcedToggle(temp: .hot)
}

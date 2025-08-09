//
//  OnlyTempView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import SwiftUI

struct OnlyTempView: View {
    let temp: CoffeeTemp

    var body: some View {
        Text(temp == .hot ? "HOT ONLY" : "ICED ONLY")
            .font(.pretendardBold(15))
            .foregroundColor(temp == .hot ? .red01.opacity(0.6) : .blue01.opacity(0.6))
            .frame(maxWidth: .infinity, minHeight: 36)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(.white)
                    .stroke(.gray)
            }
    }
}

#Preview {
    OnlyTempView(temp: .iced)
}

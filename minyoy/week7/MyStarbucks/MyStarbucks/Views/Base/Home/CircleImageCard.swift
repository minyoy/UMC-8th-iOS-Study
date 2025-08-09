//
//  CircleImageCard.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/27/25.
//

import SwiftUI

struct CircleImageCard: View {
    let model: MenuDisplayable
        
    init(model: MenuDisplayable) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 10) {
            model.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .clipShape(Circle())
            
            Text(model.name)
                .foregroundStyle(.black02)
                .font(.pretendardSemiBold(14))
        }
    }
}

#Preview {
    CircleImageCard(model: CoffeeModel(name: "아이스 카라멜 마키아또", nameEn: "Iced Caramel Macchiato", image: Image("iceCaramelMacchiato"),
                                       content: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료",
                                       price: "6,100", temperature: .iced, hasBothTemps: true))
}

//
//  OrderListItem.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/10/25.
//

import SwiftUI

struct OrderListItem: View {
    let model: OrderListModel
    
    init(model: OrderListModel) {
        self.model = model
    }
    
    var body: some View {
        HStack(spacing: 16) {
            model.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                ZStack(alignment: .topTrailing) {
                    Text(model.title)
                        .foregroundStyle(.gray06)
                        .font(.pretendardSemiBold(16))
                    
                    Circle()
                        .fill(.green01)
                        .frame(width: 6, height: 6)
                        .offset(x: 7, y: -2)
                }
                
                Text(model.titleEn)
                    .foregroundStyle(.gray03)
                    .font(.pretendardSemiBold(13))
            }
        
            Spacer()
        }
    }
}

#Preview {
    OrderListItem(model: OrderListModel(image: Image("cafeAmericano"), title: "아이스 카페 아메리카노", titleEn: "Reserve Espresso"))
}

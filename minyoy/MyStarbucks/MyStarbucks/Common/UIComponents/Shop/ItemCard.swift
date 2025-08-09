//
//  ItemCard.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/6/25.
//

import SwiftUI

struct ItemCard: View {
    let item: ItemModel
        
    init(item: ItemModel) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            item.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 157, height: 156)
                .padding(.bottom, 12)
            
            Group {
                Text(item.name)
                
                if let volume = item.volume {
                    Text("\(volume)ml")
                } else {
                    Text("")
                }
            }
            .font(.pretendardSemiBold(14))
            .foregroundColor(.black02)
        }
    }
}

#Preview {
    ItemCard(item: ItemModel(image: Image("newProduct"), name: "그린 사이렌 도트 머그", volume: 237))
}

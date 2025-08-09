//
//  ProductCard.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/5/25.
//

import SwiftUI

struct ProductCard: View {
    let model: ProductModel
        
    init(model: ProductModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 10) {
            model.image
                .resizable()
                .frame(width: 80, height: 80)
            
            Text(model.name)
                .font(.pretendardSemiBold(13))
                .foregroundStyle(.black02)
        }
    }
}

#Preview {
    ProductCard(model: ProductModel(image: Image("product1"), name: "텀블러"))
}

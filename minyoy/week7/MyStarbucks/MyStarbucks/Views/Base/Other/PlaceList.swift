//
//  PlaceList.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/18/25.
//

import SwiftUI

struct PlaceList: View {
    let model: KakaoPlace
    
    init(model: KakaoPlace) {
        self.model = model
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            contentView
            
            Divider()
                .frame(height: 1)
                .background(.gray01)
        }
        .frame(maxWidth: .infinity)
    }
    
    // 이름과 주소
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(model.place_name)
                .font(.pretendardMedium(16))
                .foregroundStyle(.black)
            
            Text(model.address_name)
                .font(.pretendardMedium(13))
                .foregroundStyle(.gray04)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    PlaceList(model: KakaoPlace(address_name: "서울 동작구 흑석동 221", place_name: "중앙대학교 서울캠퍼스", x: "0", y: "0"))
}

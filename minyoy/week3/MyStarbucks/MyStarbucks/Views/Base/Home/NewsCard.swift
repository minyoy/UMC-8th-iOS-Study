//
//  NewsCard.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import SwiftUI

struct NewsCard: View {
    let news: NewsModel
        
    init(news: NewsModel) {
        self.news = news
    }
    
    var body: some View {
        VStack {
            news.image
                .resizable()
                .frame(width: 242, height: 160)
            
            Text(news.title)
                .foregroundStyle(.black02)
                .font(.pretendardSemiBold(18))
                .frame(width: 242, alignment: .leading)
                .lineLimit(1)
                .padding(.top, 16)
            
            Text(news.subtitle.split(separator: "").joined(separator: "\u{200B}"))
                .foregroundStyle(.gray03)
                .font(.pretendardSemiBold(13))
                .frame(width: 242)
                .padding(.top, 9)
        }
    }
}

#Preview {
    NewsCard(news: NewsModel(image: Image("news"), title: "25년 3월 일회용컵 없는 날 캠페인 개최", subtitle: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."))
}

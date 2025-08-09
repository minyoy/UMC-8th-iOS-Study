//
//  NewsDataSource.swift
//  MyStarbucks
//
//  Created by 주민영 on 8/9/25.
//

import SwiftUI

struct NewsDataSource {
    static let dummyNews: [NewsModel] = [
        NewsModel(image: Image("news"), title: "25년 3월 일회용컵 없는 날 캠페인 개최", subtitle: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."),
        NewsModel(image: Image("news1"), title: "스타벅스 ooo점을 찾습니다", subtitle: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."),
        NewsModel(image: Image("news2"), title: "2월 8일, 리저브 스프링 신규 커피 출시", subtitle: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")
    ]
}

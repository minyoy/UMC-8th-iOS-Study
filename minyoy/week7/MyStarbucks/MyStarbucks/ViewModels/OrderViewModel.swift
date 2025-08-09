//
//  OrderViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/10/25.
//

import SwiftUI

@Observable
class OrderViewModel {
    var selectedTopSegment: OrderSegment = .first
    var selectedBottomSegment: CategorySegment = .first
    
    let dummyOrderList: [OrderListModel] = [
        OrderListModel(image: Image("orderList"), title: "추천", titleEn: "Recommend"),
        OrderListModel(image: Image("orderList1"), title: "아이스 카페 아메리카노", titleEn: "Reserve Espresso"),
        OrderListModel(image: Image("orderList2"), title: "카페 아메리카노", titleEn: "Reserve Drip"),
        OrderListModel(image: Image("orderList3"), title: "카푸치노", titleEn: "Dcaf Coffee"),
        OrderListModel(image: Image("orderList4"), title: "아이스 카푸치노", titleEn: "Espresso"),
        OrderListModel(image: Image("orderList5"), title: "카라멜 마키아또", titleEn: "Blonde Coffee"),
        OrderListModel(image: Image("orderList6"), title: "아이스 카라멜 마키아또", titleEn: "Cold Brew"),
        OrderListModel(image: Image("orderList7"), title: "아포가토/기타", titleEn: "Others"),
        OrderListModel(image: Image("orderList8"), title: "럼 샷 코르타도", titleEn: "Brewed Coffee"),
        OrderListModel(image: Image("orderList9"), title: "라벤더 카페 브레베", titleEn: "Teavana"),
        OrderListModel(image: Image("orderList10"), title: "병음료", titleEn: "RTD")
    ]

}

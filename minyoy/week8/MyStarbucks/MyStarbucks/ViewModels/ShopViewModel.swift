//
//  ShopViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/5/25.
//

import Foundation
import SwiftUI
import Observation

@Observable
class ShopViewModel {
//    var currentPage = 0
    
    let dummyProducts: [ProductModel] = [
        ProductModel(image: Image("product1"), name: "텀블러"),
        ProductModel(image: Image("product2"), name: "커피 용품"),
        ProductModel(image: Image("product3"), name: "선물세트"),
        ProductModel(image: Image("product4"), name: "보온병"),
        ProductModel(image: Image("product5"), name: "머그/컵"),
        ProductModel(image: Image("product6"), name: "라이프스타일"),
    ]
    
    let dummyBestItems: [ItemModel] = [
        ItemModel(image: Image("bestItem"), name: "그린 사이렌 슬리브 머그", volume: 355),
        ItemModel(image: Image("bestItem1"), name: "그린 사이렌 클래식 머그", volume: 355),
        ItemModel(image: Image("bestItem2"), name: "사이렌 머그 앤 우드 소서", volume: nil),
        ItemModel(image: Image("bestItem3"), name: "리저브 골드 테일 머그", volume: 355),
        ItemModel(image: Image("bestItem4"), name: "블랙 앤 골드 머그", volume: 473),
        ItemModel(image: Image("bestItem5"), name: "블랙 링 머그", volume: 355),
        ItemModel(image: Image("bestItem6"), name: "북청사자놀음 데미머그 ", volume: 89),
        ItemModel(image: Image("bestItem7"), name: "서울 제주 데미머그 세트", volume: nil)
    ]
    
    let dummyNewProducts: [ItemModel] = [
        ItemModel(image: Image("newProduct"), name: "그린 사이렌 도트 머그", volume: 237),
        ItemModel(image: Image("newProduct1"), name: "그린 사이렌 도트 머그", volume: 355),
        ItemModel(image: Image("newProduct2"), name: "홈 카페 미니 머그 세트", volume: nil),
        ItemModel(image: Image("newProduct3"), name: "홈 카페 글라스 세트", volume: nil)
    ]
}

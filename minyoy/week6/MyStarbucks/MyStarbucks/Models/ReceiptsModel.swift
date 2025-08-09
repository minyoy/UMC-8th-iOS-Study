//
//  ReceiptsModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/6/25.
//

import Foundation
import SwiftData

@Model
class ReceiptsModel {
    @Attribute(.unique) var id: UUID // 고유 식별자 ( 데이터베이스의 기본키처럼 동작합니다 )
    
    var store: String            // 지점
    var totalAmount: Int         // 결제 금액
    var createdAt: Date          // 저장된 시점
    
    @Relationship(.unique) var image: ReceiptsImageModel?
    
    init(
        store: String,
        totalAmount: Int,
        createdAt: Date = Date()
    ) {
        self.id = UUID()
        self.store = store
        self.totalAmount = totalAmount
        self.createdAt = createdAt
    }
}

@Model
class ReceiptsImageModel {
    @Attribute(.unique) var id: UUID
    
    @Attribute(.externalStorage) var photo: Data? // 영수증 사진
    
    @Relationship(.unique) var receipt: ReceiptsModel?

    init(id: UUID = UUID(), photo: Data) {
        self.id = id
        self.photo = photo
    }
}

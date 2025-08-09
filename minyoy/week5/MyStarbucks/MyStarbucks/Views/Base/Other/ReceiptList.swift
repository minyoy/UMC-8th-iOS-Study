//
//  ReceiptList.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/6/25.
//

import SwiftUI

struct ReceiptList: View {
    @State private var isShowingImageViewer = false
    
    let model: ReceiptsModel
    
    init(model: ReceiptsModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                contentView
                
                Spacer()
                
                showImageBtn
            }
            
            Divider()
                .frame(height: 1)
                .background(.gray02)
                .padding(.top, 14)
        }
        .frame(maxWidth: .infinity)
    }
    
    // ~점, 올린 시각, 가격 보여주는 뷰
    private var contentView: some View {
        func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter.string(from: date)
        }
        
        return VStack(alignment: .leading, spacing: 9) {
            Text(model.store)
                .font(.pretendardSemiBold(18))
                .foregroundStyle(.black)
            
            Text(formattedDate(model.createdAt))
                .font(.pretendardMedium(16))
                .foregroundStyle(.gray03)
            
            Text("\(model.totalAmount)원")
                .font(.pretendardSemiBold(18))
                .foregroundStyle(.brown02)
        }
    }
    
    // 이미지 보기 버튼
    private var showImageBtn: some View {
        Button(action: {
            print("이미지 보기")
            isShowingImageViewer = true
        }) {
            Image("receipt_icon")
        }
        .fullScreenCover(isPresented: $isShowingImageViewer, content: {
            ZStack(alignment: .topTrailing) {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    if let data = model.image?.photo,
                       let uiImage = UIImage(data: data)
                    {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    } else {
                        ProgressView()
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }

                Button(action: {
                    print("닫기")
                    isShowingImageViewer = false
                }) {
                    Image("X")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.gray04)
                        .padding(18)
                }
            }
            .transition(.scale)
        })
    }
}

#Preview {
    ReceiptList(model: ReceiptsModel(store: "홍대삼거리점", totalAmount: 4700))
}

//
//  AdPopupView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/24/25.
//

import SwiftUI

struct AdPopupView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Image("ad")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(edges: .top)
                .frame(maxWidth: .infinity, maxHeight: 720)
            
            Spacer()
                .frame(height: 106)
            
            moreButton
            
            closeButton
        }
        .padding(.bottom, 36)
    }
    
    private var moreButton: some View {
        Button(action: {
            print("자세히 보기")
        }, label: {
            Text("자세히 보기")
                .font(.pretendardMedium(18))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 58)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.green01)
                )

        })
        .padding(.horizontal, 18)
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            
            Button(action: {
                print("닫기 버튼 클릭")
                dismiss()
            }, label: {
                Text("X 닫기")
                    .font(.PretendardLight(14))
                    .foregroundStyle(.gray05)
            })
        }
        .padding(.top, 10)
        .padding(.trailing, 37)
    }
}

#Preview {
    AdPopupView()
}

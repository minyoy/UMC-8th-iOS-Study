//
//  OtherView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/24/25.
//

import Foundation
import SwiftUI

struct OtherView: View {
    @AppStorage("nickname") private var nickname: String = "(작성한 닉네임)"
    
    var body: some View {
        VStack {
            topView
            contentView
        }
    }
    
    private var topView: some View {
        HStack {
            Text("Other")
                .foregroundStyle(.black)
                .font(.pretendardBold(24))
            
            Spacer()
                .frame(width: 295)
            
            Button(action: {
                print("로그아웃")
            }, label: {
                Image("logout")
                    .resizable()
                    .frame(width: 35, height: 35)
            })
        }
        .background(.white)
    }
    
    private var contentView: some View {
        VStack {
            infoView
            
            Spacer()
            
            payView
            
            Spacer()
            
            supportView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 41)
        .background(.white01)
    }
    
    private var infoView: some View {
        VStack {
            VStack(spacing: 5) {
                HStack {
                    Text(nickname)
                        .foregroundStyle(.green01)
                        .font(.pretendardSemiBold(24))
                    Text("님")
                        .foregroundStyle(.black02)
                        .font(.pretendardSemiBold(24))
                }
                Text("환영합니다! 🙌🏻")
                    .foregroundStyle(.black02)
                    .font(.pretendardSemiBold(24))
            }
            
            HStack(spacing: 10.5) {
                InfoButton(icon: Image("star"), title: "별 히스토리")
                InfoButton(icon: Image("receipt"), title: "전자영수증")
                InfoButton(icon: Image("myCup"), title: "나만의 메뉴")
            }
            .padding(.top, 24)
        }
    }
    
    private var payView: some View {
        VStack(alignment: .leading) {
            Text("Pay")
                .font(.pretendardSemiBold(18))
                .padding(.bottom, 8)
            
            HStack {
                listItem(icon: Image("icon 1"), content: "스타벅스 카드 등록")
                
                Spacer()
                
                listItem(icon: Image("icon 2"), content: "카드 교환권 등록")
            }
            .padding(.vertical, 16)
            
            HStack {
                listItem(icon: Image("icon 3"), content: "쿠폰 등록")
                
                Spacer()
                
                listItem(icon: Image("icon 4"), content: "쿠폰 히스토리")
            }
            .padding(.vertical, 16)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .background(Color.black.opacity(0.12))
        }
        .padding(.horizontal, 10)
    }
    
    private var supportView: some View {
        VStack(alignment: .leading) {
            Text("고객지원")
                .font(.pretendardSemiBold(18))
            
            HStack {
                listItem(icon: Image("icon 5"), content: "스토어 케어")
                
                Spacer()
                
                listItem(icon:Image("icon 6"), content: "고객의 소리")
            }
            .padding(.vertical, 16)
            
            HStack {
                listItem(icon: Image("icon 7"), content: "매장 정보")
                
                Spacer()
                
                listItem(icon: Image("icon 8"), content: "반납기 정보")
            }
            .padding(.vertical, 16)
            
            HStack {
                listItem(icon: Image("icon 9"), content: "마이 스타벅스 리뷰")
                
                Spacer()
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    OtherView()
}

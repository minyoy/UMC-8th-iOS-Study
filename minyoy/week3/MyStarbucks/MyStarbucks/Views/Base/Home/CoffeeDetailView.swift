//
//  CoffeeDetailView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import SwiftUI

struct CoffeeDetailView: View {
    @Environment(NavigationRouter.self) private var router
    @Environment(HomeViewModel.self) var viewModel
    
    var body: some View {
        if let selectedCoffee = viewModel.selectedCoffeeModel {
            VStack(spacing: 0) {
                ZStack {
                    selectedCoffee.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea(edges: .top)
                        .offset(x: -35)

                    navBar
                }
                .frame(height: 355)
                
                contentView(coffee: selectedCoffee)
                    .padding(.top, 20)
                
                Spacer()
                
                orderBtn
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
    private var navBar: some View {
        VStack {
            HStack {
                Button(action : {
                    router.pop()
                }) {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.black.opacity(0.4))
                        .background(
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        )
                }
                
                Spacer()
                
                Button(action : {
                }) {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.black.opacity(0.4))
                        .background(
                            Image(systemName: "square.and.arrow.up")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        )
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    private func contentView(coffee: CoffeeModel) -> some View {
        VStack(alignment: .leading, spacing: 32) {
            titleGroup(coffee: coffee)
            
            contentGroup(coffee: coffee)
            
            if (coffee.hasBothTemps) {
                HotIcedToggle(temp: coffee.temperature)
            } else {
                OnlyTempView(temp: coffee.temperature)
            }
        }
        .padding(.horizontal, 10)
    }
    
    // 커피 한글, 영문 이름
    private func titleGroup(coffee: CoffeeModel) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Text(coffee.name)
                    .foregroundStyle(.black03)
                    .font(.pretendardSemiBold(24))
                
                Image("new")
            }
            
            Text(coffee.nameEn)
                .foregroundStyle(.gray01)
                .font(.pretendardSemiBold(14))
        }
    }
    
    // 커피 설명 및 가격
    private func contentGroup(coffee: CoffeeModel) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(coffee.content.split(separator: "").joined(separator: "\u{200B}"))
                .foregroundStyle(.gray06)
                .font(.pretendardSemiBold(14))
            
            Text(coffee.price + "원")
                .foregroundStyle(.gray11)
                .font(.pretendardBold(24))
        }
    }
    
    // 주문하기 버튼
    private var orderBtn: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .ignoresSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 80)
                .shadow(color: Color.black.opacity(0.04), radius: 5, x: 0, y: -3)
            
            Button(action: {
                print("주문하기")
            }, label: {
                Text("주문하기")
                    .font(.PretendardMedium16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 383, maxHeight: 43)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.green01)
                    )
            })
        }
    }
}

#Preview {
    CoffeeDetailView()
        .environment(NavigationRouter())
        .environment(HomeViewModel())
}

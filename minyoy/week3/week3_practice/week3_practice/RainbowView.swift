//
//  RainbowView.swift
//  week3_practice
//
//  Created by 주민영 on 3/27/25.
//

import SwiftUI

struct RainbowView: View {
    var viewModel: RainbowViewModel = .init()
    @State private var navigationTrue: Bool = false
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 40), count: 3)
    
    var body: some View {
        NavigationStack {
            VStack {
                colorCardGroup
                
                Spacer()
                
                bottomGroup
            }
            .safeAreaPadding(EdgeInsets(top: 47, leading: 15, bottom: 44, trailing: 15))
            .navigationDestination(isPresented: $navigationTrue, destination: {
                ColorNavigationView(viewModel: viewModel)
                })
        }
    }
    
    private func makeColorCard(_ model: RainbowModel) -> some View {
        VStack(spacing: 6, content: {
            Rectangle()
                .fill(model.returnColor())
            
            Text(model.returnColorName())
                .foregroundStyle(Color.black)
                .font(.title)
        })
        .frame(maxWidth: .infinity, minHeight: 110)
    }
    
    private var colorCardGroup: some View {
        LazyVGrid(columns: columns, spacing: 26, content: {
            ForEach(RainbowModel.allCases, id: \.self, content: { rainbow in
                makeColorCard(rainbow)
                    .onTapGesture {
                        viewModel.selectedRainbowModel = rainbow
                        self.navigationTrue.toggle()
                    }
            })
        })
    }
    
    private var bottomGroup: some View {
        VStack(spacing: 70) {
            Image("appleLogo")
                .renderingMode(.template)
                .fixedSize()
                .foregroundStyle(viewModel.appleLogoColor ?? Color.black)
            
            Text("현재 선택된 색상 : \(selectedColorName())")
                .font(.title)
                .foregroundStyle(Color.black)
        }
    }
    
    /// 옵셔널에 대해 값 처리를 위한 String 반환 함수
    /// - Returns: 옵셔널 값에 따른 두 가지 중 하나 값 반환
    private func selectedColorName() -> String {
        if let name = viewModel.selectedRainbowModel {
            return name.returnColorName()
        } else {
            return "아무것도 없음"
        }
    }
}

#Preview {
    RainbowView()
}

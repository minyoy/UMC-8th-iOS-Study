//
//  ShopView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/25/25.
//

import SwiftUI

struct ShopView: View {
    let ItemColumns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var currentPage = 0
    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    let viewModel: ShopViewModel = .init()
    
    var body: some View {
        ScrollView {
            headerView()
            
            LazyVStack(spacing: 44, pinnedViews: [.sectionHeaders], content: {
                Section(content: {
                    bannersView
                    
                    allProductsView
                    
                    bestItemsView
                    
                    newProducts
                }, header: {
                    pinnedHeaderView()
                        .modifier(OffsetModifier(offset: $headerOffsets.0, returnromStart: false))
                        .modifier(OffsetModifier(offset: $headerOffsets.1))
                })
            })
        }
        .ignoresSafeArea()
        .coordinateSpace(name: "SCROLL")
        .padding(.horizontal, 16)
        .background(.white01)
    }
    
    // 스타벅스 온라인 샵 + 배너
    private var bannersView: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal, content: {
                LazyHStack(spacing: 28, content: {
                    ForEach(1...3, id: \.self) { rowIndex in
                        Image("shopBanner\(rowIndex)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 270, height: 215)
                    }
                })
            })
            .scrollIndicators(.hidden)
        }
    }
    
    // 모든 상품
    private var allProductsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("All Products")
                .font(.pretendardSemiBold(22))
                .foregroundStyle(.black03)
            
            ScrollView(.horizontal, content: {
                LazyHStack(spacing: 17, content: {
                    ForEach(viewModel.dummyProducts, id: \.id) { product in
                        ProductCard(model: product)
                    }
                })
            })
            .scrollIndicators(.hidden)
        }
    }
    
    // 베스트 아이템
    private var bestItemsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Best Items")
                .font(.pretendardSemiBold(22))
                .foregroundStyle(.black03)
            
            TabView(selection: $currentPage) {
                ForEach(0..<2, id: \.self) { pageIndex in
                    LazyVGrid(columns: ItemColumns, spacing: 55) {
                        ForEach(0..<4, id: \.self) { i in
                            let itemIndex = pageIndex * 4 + i
                            let item = viewModel.dummyBestItems[itemIndex]
                            
                            ItemCard(item: item)
                        }
                    }
                }
                .padding(.bottom, 60)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 510)
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black03
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray02
            }
        }
    }
    
    
    // 신제품
    private var newProducts: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("New Products")
                .font(.pretendardSemiBold(22))
                .foregroundStyle(.black03)
            
            LazyVGrid(columns: ItemColumns, spacing: 30) {
                ForEach(viewModel.dummyNewProducts, id: \.id) { item in
                    ItemCard(item: item)
                }
            }
            .frame(height: 450)
        }
    }
    
    //커스텀 헤더
    @ViewBuilder
    private func headerView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = max(0, size.height + minY)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: -minY)
        }
        .frame(height: 20)
    }
    
    @ViewBuilder
    private func pinnedHeaderView() -> some View {
        
        let threshhold = -(getScreenSize().height * 0.05)
        
        HStack {
            if headerOffsets.0 < threshhold {
                Spacer()
            }
            
            Text("Starbucks Online Store")
                .font(headerOffsets.0 < threshhold ? .pretendardBold(18) : .pretendardBold(24))
                .foregroundStyle(.black)
                .animation(.easeInOut(duration: 0.4), value: headerOffsets.0)
            
            Spacer()
            
        }
        .frame(height: 90, alignment: .bottomLeading)
        .safeAreaPadding(.bottom, headerOffsets.0 < threshhold ? 20 : 0)
        .background(Color.white01)
    }
}

#Preview {
    ShopView()
}

//
//  OrderView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/25/25.
//

import SwiftUI

struct OrderView: View {
    @Bindable var viewModel: OrderViewModel = .init()
    
    @State private var showStoreSheet = false
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                headerView()
                
                LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                    Section(content: {
                        coffeeListView
                    }, header: {
                        pinnedHeaderView()
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    })
                }
            }
            .ignoresSafeArea()
            .scrollIndicators(.hidden)
            .background(Color.white)
            .coordinateSpace(name: "SCROLL")
            .padding(.horizontal, 20)
            
            selectStoreView
        }
        .sheet(isPresented: $showStoreSheet) {
            OrderSheetView()
        }
    }
    
    private var topSegmentView: some View {
        HStack {
            ForEach(OrderSegment.allCases, id: \.id) { segment in
                topSegment(segment: segment)
            }
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color.black.opacity(0.15))
                .frame(height: 2)
                .blur(radius: 1.5),
            alignment: .bottom
        )
    }
    
    @ViewBuilder
    func topSegment(segment: OrderSegment) -> some View {
        Button(action: {
            withAnimation {
                viewModel.selectedTopSegment = segment
            }
        }) {
            VStack(spacing: 13) {
                if segment == .third {
                    HStack(spacing: 6) {
                        Image("cake")
                        Text(segment.title)
                            .foregroundStyle(viewModel.selectedTopSegment == segment ? .black01 : .green01)
                            .font(.pretendardBold(16))
                    }
                } else {
                    Text(segment.title)
                        .foregroundStyle(viewModel.selectedTopSegment == segment ? .black01 : .gray04)
                        .font(.pretendardBold(16))
                }
                
                if viewModel.selectedTopSegment == segment {
                    Rectangle()
                        .fill(.green01)
                        .frame(maxWidth: segment == .third ? .infinity : 120)
                        .frame(height: 3)
                } else {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 3)
                }
            }
            .frame(maxWidth: segment == .third ? .infinity : 120)
            .padding(.top, 19)
        }
    }
    
    private var bottomSegmentView: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(CategorySegment.allCases, id: \.id) { segment in
                    bottomSegment(segment: segment)
                }
            }
            .padding(.leading, 23)
            
            Divider()
                .frame(height: 2)
                .foregroundStyle(.gray04)
        }
    }
    
    func bottomSegment(segment: CategorySegment) -> some View {
        HStack(spacing: 2) {
            Text(segment.title)
                .foregroundStyle(viewModel.selectedBottomSegment == segment ? .black01 : .gray04)
                .font(.pretendardSemiBold(16))
                .onTapGesture {
                    withAnimation {
                        viewModel.selectedBottomSegment = segment
                    }
                }
            
            Image("new")
        }
        .padding(EdgeInsets(top: 18, leading: 6, bottom: 8, trailing: 6))
    }
    
    private var coffeeListView: some View {
        LazyVStack(spacing: 26, content: {
            ForEach(viewModel.dummyOrderList, id: \.id) { list in
                OrderListItem(model: list)
            }
        })
        .padding(.horizontal, 23)
    }
    
    private var selectStoreView: some View {
        Button(action : {
            showStoreSheet = true
        }) {
            ZStack {
                Rectangle()
                    .fill(.black02)
                    .frame(width: 440, height: 60)
                
                VStack(alignment: .center, spacing: 7) {
                    HStack {
                        Text("주문할 매장을 선택해 주세요")
                            .font(.pretendardSemiBold(16))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Image("arrow_down")
                    }
                    
                    Divider()
                        .background(.gray06)
                        .frame(height: 3)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
            }
        }
        .buttonStyle(.plain)
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
        
        VStack(spacing: 0) {
            HStack {
                if headerOffsets.0 < threshhold {
                    Spacer()
                }
                
                Text("Order")
                    .font(headerOffsets.0 < threshhold ? .pretendardBold(18) : .pretendardBold(24))
                    .foregroundStyle(.black03)
                    .animation(.easeInOut(duration: 0.4), value: headerOffsets.0)
                    .padding(.leading, headerOffsets.0 < threshhold ? 0 : 20)
                
                Spacer()
            }
            
            topSegmentView
            
            bottomSegmentView
        }
        .frame(height: 200, alignment: .bottom)
        .safeAreaPadding(.bottom, headerOffsets.0 < threshhold ? 20 : 0)
        .background(Color.white)
    }
}

#Preview {
    OrderView()
}

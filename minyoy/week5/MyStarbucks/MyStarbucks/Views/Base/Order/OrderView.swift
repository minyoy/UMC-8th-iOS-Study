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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("Order")
                    .font(.pretendardBold(24))
                    .foregroundStyle(.black03)
                    .padding(.leading, 23)
                
                topSegmentView
                
                bottomSegmentView
                
                coffeeListView
            }
            
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
        ScrollView(.vertical, content: {
            LazyVStack(spacing: 26, content: {
                ForEach(viewModel.dummyOrderList, id: \.id) { list in
                    OrderListItem(model: list)
                }
            })
        })
        .scrollIndicators(.hidden)
        .padding(.horizontal, 23)
        .padding(.top, 19)
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
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    OrderView()
}

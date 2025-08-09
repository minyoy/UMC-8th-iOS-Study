//
//  ContentView.swift
//  week9_practice
//
//  Created by 주민영 on 6/18/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    var body: some View {
        ScrollView(.vertical, content: {
            
            VStack(spacing: 0) {
                headerView()
                
                LazyVStack(alignment: .leading, spacing: 33, pinnedViews: [.sectionHeaders], content: {
                    Section(content: {
                        ForEach(1...100, id: \.self) { item in
                            Text(String(item))
                        }
                    }, header: {
                        pinnedHeaderView()
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    })
                })
                .safeAreaPadding(.horizontal, 16)
                .contentMargins(.top, 20)
                .padding(.bottom, 100)
            }
            
        })
        .ignoresSafeArea()
        .coordinateSpace(name: "SCROLL")
        .background(Color.white)
    }
    
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
            
            Text("Learners Story")
                .font(headerOffsets.0 < threshhold ? .title : .title2)
                .animation(.easeInOut(duration: 0.4), value: headerOffsets.0)
            
            Spacer()
            
        }
        .frame(height: 90, alignment: .bottomLeading)
        .safeAreaPadding(.bottom, headerOffsets.0 < threshhold ? 20 : 0)
        .background(Color.white)
    }
}

#Preview {
    ContentView()
}


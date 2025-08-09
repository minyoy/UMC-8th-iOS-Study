//
//  ContentView.swift
//  CarouselExample
//
//  Created by 주민영 on 6/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var activeID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomCarousel(config: .init(hasOpacity: true, hasScale: true, cardWidth: 200), selection: $activeID, data: images) { item in
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(height: 180)
            }
            .navigationTitle("Cover Carousel")
        }
    }
}

#Preview {
    ContentView()
}

//
//  BaseTabView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/24/25.
//

import SwiftUI

struct BaseTabView: View {
    var body: some View {
        TabView {
            Tab("Home", image: "Home") {
                HomeView()
            }
            Tab("Pay", image: "Pay") {
                PayView()
            }
            Tab("Order", image: "Order") {
                OrderView()
            }
            Tab("Shop", image: "Shop") {
                ShopView()
            }
            Tab("Other", image: "Other") {
                OtherView()
            }
        }
        .tint(.green01)
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

#Preview {
    BaseTabView()
}

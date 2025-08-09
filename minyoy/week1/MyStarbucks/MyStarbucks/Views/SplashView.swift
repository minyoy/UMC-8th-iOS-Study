//
//  SplashView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/19/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image(.starbucks)
                .resizable()
                .frame(width: 168, height: 168)
                .aspectRatio(contentMode: .fit)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(.green01)
    }
}

#Preview {
    SplashView()
}

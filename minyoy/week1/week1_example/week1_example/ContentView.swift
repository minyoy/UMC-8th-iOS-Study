//
//  ContentView.swift
//  week1_example
//
//  Created by 주민영 on 3/18/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}

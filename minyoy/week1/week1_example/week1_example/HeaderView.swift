//
//  HeaderView.swift
//  week1_example
//
//  Created by 주민영 on 3/18/25.
//

/* HeaderView */

import SwiftUI

struct HeaderView: View {
    
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .foregroundStyle(Color.red)
            .font(.largeTitle)
    }
}

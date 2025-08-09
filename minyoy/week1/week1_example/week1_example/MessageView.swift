//
//  MessageView.swift
//  week1_example
//
//  Created by 주민영 on 3/18/25.
//

/* MessageView */

import SwiftUI

struct MessageView: View {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        Text(message)
            .font(.title)
            .foregroundStyle(Color.green)
    }
}

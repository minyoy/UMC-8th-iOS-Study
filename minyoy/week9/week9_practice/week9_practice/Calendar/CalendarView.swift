//
//  CalendarView.swift
//  week9_practice
//
//  Created by 주민영 on 6/18/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                
                Group {
                    Text("1. automatic")
                        .font(.headline)
                    DatePicker("자동 스타일", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.automatic)
                }

                Group {
                    Text("2. compact")
                        .font(.headline)
                    DatePicker("Compact 스타일", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                }

                Group {
                    Text("3. wheel")
                        .font(.headline)
                    DatePicker("Wheel 스타일", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.wheel)
                }

                Group {
                    Text("4. graphical")
                        .font(.headline)
                    DatePicker("Graphical 스타일", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                }

                Divider()
                
                Text("선택된 날짜: \(selectedDate.formatted(date: .long, time: .omitted))")
                    .font(.subheadline)
                    .padding(.top, 20)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}


#Preview {
    CalendarView()
}

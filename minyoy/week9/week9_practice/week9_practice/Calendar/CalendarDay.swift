//
//  CalendarDay.swift
//  week9_practice
//
//  Created by 주민영 on 6/18/25.
//

import Foundation

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
    let isHoliday: Bool
}

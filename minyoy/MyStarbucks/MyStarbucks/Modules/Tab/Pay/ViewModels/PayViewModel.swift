//
//  PayViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 6/17/25.
//

import SwiftUI
import SwiftData

@Observable
class PayViewModel {
    var context: ModelContext?
    
    var activeID: UUID?
    var activeCard: Card?
    
    func updateActiveCard(cards: [Card]) {
        guard let activeID else {
            activeCard = nil
            return
        }

        /// 카드 바꾸면 정보 업데이트 및 타이머 초기화
        if let matchedCard = cards.first(where: { $0.id == activeID }) {
            activeCard = matchedCard
            timeRemaining = 180
            startTimer()
        } else {
            activeCard = nil
        }
    }
    
    /// 타이머 사용
    var timer: Timer?
    var timeRemaining: Int = 180
    
    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        stopTimer()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

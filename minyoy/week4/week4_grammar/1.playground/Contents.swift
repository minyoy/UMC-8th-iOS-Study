import SwiftUI

// 1. "최종 결제 금액: (최종 결제 금액)원"과 같이 출력되도록 작성해주세요!
func calculateTotalPrice(total: Int, tip: Int) -> Int {
    return total + tip
}
print("최종 결제 금액: \(calculateTotalPrice(total: 21000, tip: 1000))원")

// 2. "덥다", "춥다", "적당하다"와 같이 출력되도록 작성해주세요!
func checkTemperature(temp: Int) {
    if (temp > 30) {
        print("덥다")
    } else if (temp > 10) {
        print("적당하다")
    } else {
        print("춥다")
    }
}
checkTemperature(temp: 9)

// 3. "(여행지)에서의 총 여행 예산은 (총 예산)원입니다."와 같이 출력되도록 작성해주세요!
func printTravelBudget(city: String, days: Int, dailyBudget: Int) {
    print("\(city)에서의 총 여행 예산은 \(days * dailyBudget)원입니다.")
}
printTravelBudget(city: "프랑스", days: 7, dailyBudget: 100000)

// 4. "오늘 날짜: 2024-09-19"와 같이 오늘 날짜가 "YYYY-MM-DD" 형식으로 출력되도록 작성해주세요!
func getCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date())
}

print("오늘 날짜: \(getCurrentDate())")

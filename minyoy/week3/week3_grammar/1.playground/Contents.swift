// 1. 학생들의 점수 딕셔너리 선언
var studentScore: [String: Int] = ["Alice": 100, "Bob": 80, "Min": 50]


// 2. “Alice”의 점수를 95점으로 수정
studentScore["Alice"] = 95


// 3. “Bob”의 점수를 삭제하고, 남은 학생들의 점수를 출력
studentScore.removeValue(forKey: "Bob")
for (name, score) in studentScore {
    print("\(name)의 점수 \(score)")
}

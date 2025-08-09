// 1. 단항 연산자: 변수 x의 값을 5로 초기화한 후 1 증가시키고, 증가된 값을 출력
var x = 5
x += 1
print("x: \(x)")

// 2. 이항 연산자: 변수 a와 b를 각각 10과 20으로 초기화한 뒤 더한 결과를 변수 sum에 저장하고, 그 결과를 출력
var a = 10
var b = 20
var sum = a + b
print("sum: \(sum)")

// 3. 삼항 연산자: 변수 score가 60 이상이면 "합격", 그렇지 않으면 "불합격"을 출력
var score = 67
print(score >= 60 ? "합격" : "불합격")

// 4. 논리 연산자: 변수 isMember가 true이고 points가 100 이상이면 "할인 가능", 그렇지 않으면 "할인 불가능"을 출력
var isMember = false
var points = 101
if (isMember == true && points >= 100) {
    print("할인 가능")
} else {
    print("할인 불가능")
}

// 5. 범위 연산자: 변수 numbers에 1부터 5까지의 숫자를 저장하고, 이 숫자들을 출력
var numbers: [Int] = []
for index in 1...5 {
    numbers.append(index)
}
print(numbers.map{String($0)}.joined(separator: ", "))

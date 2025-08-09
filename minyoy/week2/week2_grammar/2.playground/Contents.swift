// 1. if문: temperature가 30 이상이면 "덥다", 10 이상 30 미만이면 "적당하다", 그렇지 않으면 "춥다"를 출력
var temperature = 20
if (temperature >= 30) {
    print("덥다")
} else if (temperature >= 10) {
    print("적당하다")
} else {
    print("춥다")
}

// 2. switch문: day에 따른 요일을 출력하고, 1~5는 "주중", 6과 7은 "주말"을 출력
var day = 3
switch day {
case 1...5:
    print("주중")
case 6...7:
    print("주말")
default:
    print("올바르지 않은 숫자")
}

// 1. Int 변수를 파라미터로 받는 addValue 클로저를 선언하고 출력해주세요! 값은 임의로 넣어주세요.
let addValue1 = { (num: Int) -> Int in
    var sum = 0
    for i in 1...num {
        sum += i
    }
    return sum
}
print(addValue1(10))

// 2. 1번에서 선언한 addValue 클로저를 $를 이용해 경량화 시킨 코드를 아래 넣어주세요!
let addValue2: (Int) -> Int = {
    (1...$0).reduce(0, +)
}
print(addValue2(10))

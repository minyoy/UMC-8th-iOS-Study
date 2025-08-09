// 1. 과일 목록 세트 선언
var fruits: Set<String> = ["Apple", "Banana", "Orange"]

// 2. “Banana”가 이미 존재하는지 확인하고, 존재하면 “Mango”를 추가하세요
if (fruits.contains("Banana")) {
    fruits.insert("Mango")
}

// 3. 세트에 있는 모든 과일을 반복문으로 출력하세요
for fruit in fruits {
    print(fruit)
}

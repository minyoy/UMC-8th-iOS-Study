class Rectangle {
    var width: Int
    var height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    var area: Int {
        get {
            return self.width * self.height
        }
    }
    
    static let unit: String = "cm"
}

// 1. "사각형의 너비: \(rectangle.width) cm, 높이: \(rectangle.height) cm"와 같이 출력되도록 작성해주세요!
var rectangle = Rectangle(width: 10, height: 20)
print("사각형의 너비: \(rectangle.width) cm, 높이: \(rectangle.height) cm")

// 2. "사각형의 면적: \(rectangle.area) cm²"와 같이 출력되도록 작성해주세요!
print("사각형의 면적: \(rectangle.area) cm²")

// 3. "사각형의 면적: \(rectangle.area) \(Rectangle.unit)²" 형식으로 출력되도록 작성해주세요!
print("사각형의 면적: \(rectangle.area) \(Rectangle.unit)²")

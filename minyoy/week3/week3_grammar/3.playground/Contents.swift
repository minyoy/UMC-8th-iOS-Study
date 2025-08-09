// 1. 네트워크 요청 상태 열거형 정의
enum NetworkRequestState {
    case idle
    case requesting 
    case success(String)
    case failure(String)
}


// 2. 네트워크 요청 상태를 나타내는 변수 선언
var currentState: NetworkRequestState = .success("데이터 로드 완료")


// 3. switch문으로 상태에 맞는 출력 작성
switch currentState {
case .idle:
    print("현재 대기 상태입니다.")
case .requesting:
    print("요청 중입니다...")
case .success(let success):
    print("요청 성공: \(success)")
case .failure(let error):
    print("요청 실패: \(error)")
}

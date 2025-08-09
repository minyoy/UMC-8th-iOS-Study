# Starbucks Clone Coding
* SwiftUI 기반 MVVM 아키텍처로 설계된 iOS 애플리케이션입니다.
* 해당 프로젝트는 UMC 8기 iOS 개인 학습용 과제 프로젝트입니다.

<br/>

## 구현 기능 (Features)
1. 화면 및 네비게이션
   - SwiftUI 기반 UI 구현
   - NavigationStack을 활용한 화면 전환 구조 설계

2. 인증 및 보안
   - 카카오 로그인 구현
   - 키체인(Keychain)을 이용한 액세스 토큰 안전 저장

3. 영수증 OCR
   - OCR 기능으로 영수증 이미지에서 텍스트 인식
   - 인식한 결과를 SwiftData에 저장·관리

4. 매장 정렬 및 지도 시각화
   - 스타벅스 매장 JSON 데이터를 활용해 가까운 매장 순으로 정렬
   - 카카오 키워드 검색 API로 장소 검색 결과 제공
   - MapKit + CLLocationManager로 주변 매장을 지도에 핀으로 표시
   - Google Places Image API로 매장 이미지를 불러와 표시

5. 길찾기 안내
   - OSRM(Open Source Routing Machine)을 사용해 출발지·도착지 간 길찾기 경로를 지도에 표시

6. 이미지 생성 및 저장
    - Stable Diffusion WebUI AI Model 기반 이미지 생성 API 연동
    - 생성한 이미지를 카드 정보와 함께 SwiftData에 저장

<br/>

## 폴더 구조 (Directory Structure)
```
MyStarbucks
├── App
├── Common
│ └── Enum
│	└── UIComponents
├── Core
│	└── DIContainer
│	└── Navigation
│	└── Utils
├── Datas
├── Models
│	└── DTO
│	└── Domain
├── Modules
│	└── AppFlow
│	└── Tab
├── Resource
│	└── Assets
│	└── Extension
│	└── Font
│	└── Keychain
│	└── Modifier
├── Service
│	└── Common
│	└── MoyaRouter
│	└── Social
```

<br/>

## 시연 영상

### 1. 영수증 OCR
<img src="https://github.com/user-attachments/assets/5415c0a0-15c6-4de9-aeab-cf80c5c74a3a" width="400" />

### 2. 매장 정렬
<img src="https://github.com/user-attachments/assets/5e30bb7a-8a9e-479d-8dce-0d920ca08a63" width="400" />

### 3. 지도 시각화 & 길찾기 안내
<img src="https://github.com/user-attachments/assets/c6fd0646-a9c5-4c3d-bd68-5917ed0000c1" width="400" />

### 4. 이미지 생성 및 저장
<img src="https://github.com/user-attachments/assets/45a943f0-cc9c-4db7-81da-ec0870b77305" width="400" />

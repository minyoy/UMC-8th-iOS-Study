//
//  CombineViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 6/17/25.
//

import SwiftUI
import CombineMoya
import Combine
import Moya
import SwiftData

class CombineViewModel: ObservableObject {
    var context: ModelContext?

    private var cancellables = Set<AnyCancellable>()
    
    private let provider: MoyaProvider<ImageRouter>
    
    @Published var isLoading: Bool = false
    @Published var progress: Double?
    
    @Published var name: String = ""
    @Published var num: String = ""
    @Published var image: UIImage?
    
    init(provider: MoyaProvider<ImageRouter> = APIManager.shared.createImageProvider(for: ImageRouter.self)) {
        self.provider = provider
    }
    
    /// 이미지 생성해 2초마다 퍼센트 받아오게 하는 함수
    func startImageGeneration() {
        self.isLoading = true

        Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, self.isLoading else { return }
                self.getProgress()
                    .sink { progress in
                        print("progress: \(progress?.progress ?? 0)")
                        self.progress = progress?.progress
                    }
                    .store(in: &self.cancellables)
            }
            .store(in: &cancellables)

        generateImg()
            .compactMap { $0?.images.first }
            .map { base64 -> UIImage? in
                guard let data = Data(base64Encoded: base64),
                      let image = UIImage(data: data) else {
                    print("❌ 이미지 디코딩 실패")
                    return nil
                }
                return image
            }
            .sink { [weak self] image in
                self?.image = image
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    /// 이미지 생성 API 요청 보내는 함수
    private func generateImg() -> AnyPublisher<Txt2ImgImageOnlyResponse?, Never> {
        provider.requestPublisher(.postTxt2Img(request:
            Txt2ImgRequest(
                prompt: "a single stylish Starbucks gift card, isolated, no background, transparent background, centered, elegant minimal layout, green and white theme, modern typography, realistic 3D render, sharp edges, floating appearance",
                negativePrompt: "blurry, low quality, distorted, poorly drawn, extra objects, hands, fingers, multiple cards, background clutter, text artifacts, watermark, pixelated, oversaturated, reflections, busy background"
        )))
            .map(\.data)
            .decode(type: Txt2ImgImageOnlyResponse.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .catch { error -> Just<Txt2ImgImageOnlyResponse?> in
               DispatchQueue.main.async {
                   print("에러: \(error.localizedDescription)")
               }
               return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    /// 프로그래스 퍼센트 받아오는 API 요청 함수
    private func getProgress() -> AnyPublisher<Txt2ImgProgressOnlyResponse?, Never> {
        provider.requestPublisher(.getProgress)
            .map(\.data)
            .decode(type: Txt2ImgProgressOnlyResponse.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .catch { error -> Just<Txt2ImgProgressOnlyResponse?> in
               DispatchQueue.main.async {
                   print("에러: \(error.localizedDescription)")
               }
               return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    /// 값을 SwiftData에 저장하는 함수
    func saveCard() {
        guard let context = self.context else { return }
        let name = self.name
        let num = self.num
        let price = Int.random(in: 0...19_999_999)

        let finalImage: UIImage
        if let image = self.image {
            finalImage = image
        } else {
            finalImage = UIImage(named: "Card1") ?? UIImage()
        }

        let newCard = Card(name: name, price: price, num: num, image: finalImage)

        context.insert(newCard)
    }

}

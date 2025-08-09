//
//  StoreListItemViewModel.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/18/25.
//

import Foundation
import Moya

@Observable
class StoreListItemViewModel {
    let provider: MoyaProvider<PlaceRouter>
    
    init(provider: MoyaProvider<PlaceRouter> = APIManager.shared.createProvider(for: PlaceRouter.self)) {
        self.provider = provider
    }
    
//    init(provider: MoyaProvider<PlaceRouter> = APIManager.shared.testProvider(for: PlaceRouter.self)) {
//        self.provider = provider
//    }
    
    func getPhotoReference(Store_nm: String) async -> String {
        do {
            let query = "\(Store_nm)점 스타벅스"
            let response = try await provider.requestAsync(.getGooglePlaceSearch(query: query))
            let place = try JSONDecoder().decode(GooglePlacesResponse.self, from: response.data)
            print("photo_reference", place.results[0].photos[0].photo_reference)
            
            return place.results[0].photos[0].photo_reference
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
        }
        return "photo_reference 없음"
    }
}

extension MoyaProvider {
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

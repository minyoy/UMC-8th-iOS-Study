//
//  KakaoAPIService.swift
//  week6_practice
//
//  Created by 주민영 on 5/12/25.
//

import Foundation
import Alamofire

class KakaoAPIService {
    static let shared = KakaoAPIService()
    
    private let session: Session
    
    private init() {
        let interceptor = KakaoInterceptor(apiKey: "KakaoAK 018665eb2d28012e92550b86f3c82078")
        self.session = Session(interceptor: interceptor)
    }
    
    
    func searchBook(query: String) async throws -> BookModel {
        let url = "https://dapi.kakao.com/v3/search/book"
        let parameters: [String: Any] = [
            "query": query,
            "target": "isbn"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data),
                           let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                           let jsonString = String(data: jsonData, encoding: .utf8) {
                            print("Kakao API 응답 JSON:\n\(jsonString)")
                        }
                        
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let bookModel = try decoder.decode(BookModel.self, from: data)
                            
                            if bookModel.documents.isEmpty {
                                continuation.resume(throwing: KakaoBookAPIError.noResult)
                            } else {
                                continuation.resume(returning: bookModel)
                            }
                        } catch {
                            continuation.resume(throwing: KakaoBookAPIError.invalidResponse)
                        }
                        
                    case .failure(let error):
                        continuation.resume(throwing: KakaoBookAPIError.network(error))
                    }
                }
        }
    }
    
}

//
//  KakaoAPIService.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/12/25.
//

import Foundation
import Alamofire
import AuthenticationServices
import UIKit

class KakaoAPIService: NSObject {
    static let shared = KakaoAPIService()
    
    private let session: Session
    
    private let clientID = "kakaoAK \(Config.restApiKey)"
    private let redirectURI = "myapp://oauth"
    
    private lazy var authURL = URL(string:
        "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=\(clientID)&redirect_uri=\(redirectURI)"
    )!
    
    let scheme = "myapp"
    
    private var currentSession: ASWebAuthenticationSession?
    
    private override init() {
        let interceptor = KakaoInterceptor(apiKey: Config.restApiKey)
        self.session = Session(interceptor: interceptor)
    }

    // 인가 코드 받아서 액세스 토큰까지 요청하는 함수
    func requestCode(presentingWindow: ASPresentationAnchor, completion: @escaping (Result<KakaoLoginResponse, Error>) -> Void) {
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme) { callbackURL, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let callbackURL = callbackURL,
                  let code = URLComponents(string: callbackURL.absoluteString)?
                    .queryItems?.first(where: { $0.name == "code" })?.value else {
                completion(.failure(NSError(domain: "KakaoAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "인가 코드 추출 실패"])))
                return
            }
            
            self.requestAccessToken(with: code, completion: completion)
        }
        
        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        session.start()
        self.currentSession = session
    }

    // 토큰 요청 함수
    func requestAccessToken(with authCode: String, completion: @escaping (Result<KakaoLoginResponse, Error>) -> Void) {
        let url = "https://kauth.kakao.com/oauth/token"
        
        let parameters: [String: Any] = [
            "grant_type": "authorization_code",
            "client_id": clientID,
            "redirect_uri": redirectURI,
            "code": authCode
        ]
        
        session.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [
            "Content-Type": "application/x-www-form-urlencoded"
        ])
        .validate()
        .responseDecodable(of: KakaoLoginResponse.self) { response in
            switch response.result {
            case .success(let token):
                KeychainService.shared.saveToken(accessToken: token.accessToken, refreshToken: token.refreshToken)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// Web 인증을 위한 presentationAnchor 설정
extension KakaoAPIService: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first ?? ASPresentationAnchor()
    }
}

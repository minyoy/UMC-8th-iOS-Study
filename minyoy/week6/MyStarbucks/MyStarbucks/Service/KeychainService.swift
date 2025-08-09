//
//  KeychainService.swift
//  MyStarbucks
//
//  Created by 주민영 on 5/12/25.
//

import Foundation
import Security

class KeychainService {
    static let shared = KeychainService()
    
    private init() {}
    
    // MARK: - UserInfo 저장
    private let account = "userInfo"
    private let service = "com.myKeychain.userInfo"
    
    @discardableResult
    private func saveUserInfo(_ userInfo: UserInfo) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(userInfo)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            SecItemDelete(query as CFDictionary)
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("JSON 인코딩 실패:", error)
            return errSecParam
        }
    }
    
    private func loadUserInfo() -> UserInfo? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data else {
            print("유저 정보 불러오기 실패 - status:", status)
            return nil
        }
        
        do {
            return try JSONDecoder().decode(UserInfo.self, from: data)
        } catch {
            print("❌ JSON 디코딩 실패:", error)
            return nil
        }
    }
    
    @discardableResult
    private func deleteUserInfo() -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        return SecItemDelete(query as CFDictionary)
    }
    
    public func save(userInfo: UserInfo) {
        let status = saveUserInfo(userInfo)
        print(status == errSecSuccess ? "저장 성공" : "저장 실패")
    }
    
    public func load() -> UserInfo? {
        if let userInfo = loadUserInfo() {
            print("✅ 불러오기 성공")
            print("EMAIL:", userInfo.email)
            print("Password:", userInfo.password)
            print("Nickname:", userInfo.nickname)
            return userInfo
        } else {
            print("❌ 저장된 유저 정보 없음")
            return nil
        }
    }
    
    public func delete() {
        let status = deleteUserInfo()
        print(status == errSecSuccess ? "삭제 성공" : "삭제 실패")
    }
    
    public func loadNickname() -> String? {
        if let userInfo = loadUserInfo() {
            return userInfo.nickname
        } else {
            return nil
        }
    }
    
    // MARK: - Token 저장
    
    private let tokenAccount = "authToken"
    private let tokenService = "com.myKeychain.tokenInfo"
    
    @discardableResult
    private func saveTokenInfo(_ tokenInfo: TokenInfo) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(tokenInfo)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: tokenAccount,
                kSecAttrService as String: tokenService,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            SecItemDelete(query as CFDictionary)
            
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("JSON 인코딩 실패:", error)
            return errSecParam
        }
    }
    
    private func loadTokenInfo() -> TokenInfo? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenAccount,
            kSecAttrService as String: tokenService,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data else {
            print("토큰 정보 불러오기 실패 - status:", status)
            return nil
        }
        
        do {
            return try JSONDecoder().decode(TokenInfo.self, from: data)
        } catch {
            print("❌ JSON 디코딩 실패:", error)
            return nil
        }
    }
    
    @discardableResult
    private func deleteTokenInfo() -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenAccount,
            kSecAttrService as String: tokenService
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
    
    public func saveToken(accessToken: String, refreshToken: String) {
        let tokenInfo = TokenInfo(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
        let saveStatus = self.saveTokenInfo(tokenInfo)
        print(saveStatus == errSecSuccess ? "저장 성공" : "저장 실패")
    }
    
    public func loadToken() {
        if let loadedToken = self.loadTokenInfo() {
            print("accessToken:", loadedToken.accessToken)
            print("RefreshToken:", loadedToken.refreshToken)
        } else {
            print("토큰 정보 없음")
        }
    }
    
    public func deleteToken() {
        let deleteStatus = self.deleteTokenInfo()
        print(deleteStatus == errSecSuccess ? "삭제 성공" : "삭제 실패")
    }
}


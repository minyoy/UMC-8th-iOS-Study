//MARK: POST
//import SwiftUI
//
//let url = URL(string: "http://localhost:9090/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//
//let parameters: [String: Any] = [
//      "name": "제옹",
//      "age": 29,
//      "address": "포항시 대잠동",
//      "height": 178
//]
//
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//
//task.resume()

//MARK: GET
//import SwiftUI
//
//var urlComponents = URLComponents(string: "http://localhost:9090/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "제옹")
//]
//
//let url = urlComponents.url!
//
//let task = URLSession.shared.dataTask(with: url) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

//MARK: PATCH
//import SwiftUI
//
//let url = URL(string: "http://localhost:9090/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PATCH"
//
//let parameters: [String: Any] = [
//    "name": "Je-Ong",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

//MARK: PUT
//import SwiftUI
//
//let url = URL(string: "http://localhost:9090/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PUT"
//
//// 요청 본문에 전송할 데이터
//let parameters: [String: Any] = [
//    "name": "제옹",
//    "age": 333,
//    "address": "경기도 수원시",
//    "height": 222
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()

//MARK: DELETE
//import SwiftUI
//
//var urlComponents = URLComponents(string: "http://localhost:9090/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "제옹")
//]
//
//let url = urlComponents.url!
//var request = URLRequest(url: url)
//request.httpMethod = "DELETE"
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("Status Code: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("Response Data: \(responseString!)")
//    }
//}
//task.resume()

//MARK: 비동기 GET
//import SwiftUI
//
//actor NetworkManager {
//    func getUserData() async throws -> String {
//        var urlComponents = URLComponents(string: "http://localhost:9090/person")!
//        urlComponents.queryItems = [
//            URLQueryItem(name: "name", value: "제옹")
//        ]
//        
//        guard let url = urlComponents.url else {
//            throw URLError(.badURL)
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw URLError(.badServerResponse)
//        }
//        
//        guard let responseString = String(data: data, encoding: .utf8) else {
//            throw URLError(.cannotDecodeContentData)
//        }
//        
//        return responseString
//    }
//}
//
//let networkManager = NetworkManager()
//
//Task {
//    do {
//        let result = try await networkManager.getUserData()
//        print("응답 데이터:", result)
//    } catch {
//        print("네트워크 에러", error)
//    }
//}

//MARK: 비동기 POST
//import SwiftUI
//
//actor NetworkManager {
//    func postUserData() async throws -> String {
//        var urlComponents = URLComponents(string: "http://localhost:9090/person")!
//        guard let url = urlComponents.url else {
//            throw URLError(.badURL)
//        }
//        
//        let parameters: [String: Any] = [
//              "name": "제옹",
//              "age": 29,
//              "address": "포항시 대잠동",
//              "height": 178
//        ]
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw URLError(.badServerResponse)
//        }
//        
//        guard let responseString = String(data: data, encoding: .utf8) else {
//            throw URLError(.cannotDecodeContentData)
//        }
//        
//        return responseString
//    }
//}
//
//let networkManager = NetworkManager()
//
//Task {
//    do {
//        let result = try await networkManager.postUserData()
//        print("응답 데이터:", result)
//    } catch {
//        print("네트워크 에러", error)
//    }
//}

//MARK: 비동기 DELETE
import SwiftUI

actor NetworkManager {
    func deleteUserData() async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:9090/person")!
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "제옹")
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return responseString
    }
}

let networkManager = NetworkManager()

Task {
    do {
        let result = try await networkManager.deleteUserData()
        print("응답 데이터:", result)
    } catch {
        print("네트워크 에러", error)
    }
}

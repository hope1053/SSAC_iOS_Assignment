//
//  APIService.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case invalidToken
}

class APIService {
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        var request = URLRequest(url: Endpoint.register.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func viewPosts(completion: @escaping (Post?, APIError?) -> Void) {
        let loginToken = UserDefaults.standard.value(forKey: "token") ?? ""
        var request = URLRequest(url: Endpoint.post.url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(loginToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func addPost(text: String, completion: @escaping (PostElement?, APIError?) -> Void) {
        let loginToken = UserDefaults.standard.value(forKey: "token") ?? ""
        var request = URLRequest(url: Endpoint.post.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(loginToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func deletePost(id: Int, completion: @escaping (PostElement?, APIError?) -> Void) {
        let loginToken = UserDefaults.standard.value(forKey: "token") ?? ""
        
        var request = URLRequest(url: Endpoint.editPost(id: id).url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(loginToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
}

//
//  Endpoint.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case DELETE
}

enum Endpoint {
    case register
    case login
    case post
    case editPost(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .register:
            return .makeEndpoint("auth/local/register")
        case .login:
            return .makeEndpoint("auth/local")
        case .post:
            return .makeEndpoint("posts")
        case .editPost(id: let id):
            return .makeEndpoint("posts/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
    static func makeEndpoint(_ endPoint: String) -> URL {
        URL(string: baseURL + endPoint)!
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endPoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    if response.statusCode == 401 {
                        print(response)
                        completion(nil, .invalidToken)
                        return
                    } else {
                        completion(nil, .failed)
                        return
                    }
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)

                    completion(decodedData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
        }
    }
}

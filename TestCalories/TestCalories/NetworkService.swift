//
//  NetworkService.swift
//  TestCalories
//
//  Created by Levon Shaxbazyan on 08.10.24.
//

import Foundation

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error, Equatable {
    case invalidURL
    case noHTTPURLResponse
    case noData
    case notModified
    case httpError(statusCode: Int)
}

enum URLQueries: String {
    
    /// для получения списка продуктов
    case foodsList = "v1/foods/list"
}

class NetworkService {
    static let shared = NetworkService()
        
    enum BaseUrlType: String {
        case baseUrl = "https://api.nal.usda.gov/fdc/"
    }
    
    private init() {}
    
    func sendRequest(
        baseURL: BaseUrlType,
        query: URLQueries,
        httpMethod: HttpMethod,
        token: String? = nil,
        parameters: [String: Any]?,
        inQueryParameter: String? = "",
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        
        var url = URL(string: "")
        
        if let inQueryParameter = inQueryParameter, inQueryParameter != "" {
            url = URL(string: baseURL.rawValue + query.rawValue + "?" + inQueryParameter)
            } else {
            url = URL(string: baseURL.rawValue + query.rawValue)
        }
        
        guard let url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.noHTTPURLResponse))
                return
            }
            
            if 200 ..< 300 ~= httpResponse.statusCode {
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.httpError(
                        statusCode: httpResponse.statusCode))
                    )
                }
            }
        }.resume()
    }
    
}

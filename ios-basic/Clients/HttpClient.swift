//
//  HttpClient.swift
//  ios-basic
//
//  Created by 이승희 on 11/18/23.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unabled to perform request", comment: "badRequestError")
            case .serverError(let errorMessage):
                return NSLocalizedString(errorMessage, comment: "serverError")
            case .decodingError:
                return NSLocalizedString("Unabled to decode successfully", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response", comment: "invalidResponse")
        }
    }
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var modelType: T.Type
}

struct HttpClient {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T{
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .get(let queryItems):
                var componets = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                componets?.queryItems = queryItems
                guard let url = componets?.url else {
                    throw NetworkError.badRequest
                }
                request = URLRequest(url: url)
            case .post(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            case .delete:
                request.httpMethod = resource.method.name
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        
        let(data, response) = try await session.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try?JSONDecoder().decode(resource.modelType, from: data) else {
            throw NetworkError.decodingError
        }
        return result
    }
}

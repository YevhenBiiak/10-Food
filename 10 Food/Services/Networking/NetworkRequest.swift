//
//  NetworkRequest.swift
//  10 Food
//
//  Created by Yevhen Biiak on 24.01.2023.
//

import Foundation

protocol NetworkRequest {
    associatedtype Model
    var url: URL { get }
    func decode(_ data: Data) throws -> Model
    func execute(withCompletion completion: @escaping (Result<Model, Error>) -> Void)
}

extension NetworkRequest {
    func execute(withCompletion completion: @escaping (Result<Model, Error>) -> Void) {
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkRequestError.badRequest(statusCode: statusCode)))
                    }
                }
                
                let result = Result { try decode(data) }
                DispatchQueue.main.async { completion(result) }
            } catch {
                // check internet connection
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
}

enum NetworkRequestError: Error, LocalizedError {
    case decodingError
    case badRequest(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Decoding error"
        case .badRequest(statusCode: let code):
            return "Bad request. Response status code: \(code)"
        }
    }
}

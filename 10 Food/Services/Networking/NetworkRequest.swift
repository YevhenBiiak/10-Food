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
    func decode(_ data: Data) -> Result<Model, Error>
    func execute(withCompletion completion: @escaping (Result<Model, Error>) -> Void)
}

extension NetworkRequest {
    func execute(withCompletion completion: @escaping (Result<Model, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            if let error {
                // check internet connection
                return completion(.failure(error))
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
                return completion(.failure(NetworkRequestError.badRequest(statusCode: statusCode)))
            }
            
            if let data  {
                let result = decode(data)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
        task.resume()
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

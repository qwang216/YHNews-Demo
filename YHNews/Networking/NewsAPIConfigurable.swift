//
//  ViewController.swift
//  YHNews
//
//  Created by Jason Wang on 2/11/23.
//

import Foundation

enum NewsAPIError: Error {
    case apiNetworkError
}

protocol NewsAPIConfigurable: NewsExecutable, DecodableObject {
    @discardableResult
    func executeDecodableRequest<T: Decodable>(queue: DispatchQueue,
                                               objectType: T.Type,
                                               onCompletion: @escaping (Result<T, NewsAPIError>) -> Void) -> URLSessionDataTask?
}
extension NewsAPIConfigurable {
    @discardableResult
    func executeDecodableRequest<T: Decodable>(queue: DispatchQueue,
                                               objectType: T.Type,
                                               onCompletion: @escaping (Result<T, NewsAPIError>) -> Void) -> URLSessionDataTask? {
        return executeRequest(queue: .main, session: .shared) { result in
            switch result {
            case .success(let data):
                let response = Self.decode(objectType, from: data)
                if case .success(let responseData) = data {
                    onCompletion(.success(responseData))
                } else {
                    onCompletion(.failure(.apiNetworkError))
                }
            case .failure(_):
                onCompletion(.failure(.apiNetworkError))
            }
        }
    }
}

//
//  ExecuteDecodable.swift
//  YHNews
//
//  Created by Jason Wang on 2/14/23.
//

import Foundation

protocol ExecuteDecodable: Executable, DecodableObject {
    @discardableResult
    func executeDecodableRequest<T: Decodable>(queue: DispatchQueue,
                                               objectType: T.Type,
                                               onCompletion: @escaping (Result<T, NewsAPIError>) -> Void) -> URLSessionDataTask?
}
extension ExecuteDecodable {
    @discardableResult
    func executeDecodableRequest<T: Decodable>(queue: DispatchQueue,
                                               objectType: T.Type,
                                               onCompletion: @escaping (Result<T, NewsAPIError>) -> Void) -> URLSessionDataTask? {
        return executeRequest(queue: .main, session: .shared) { result in
            switch result {
            case .success(let data):
                let response = Self.decode(objectType, from: data)
                if case .success(let responseData) = response {
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

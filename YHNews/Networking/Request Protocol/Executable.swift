//
//  Executable.swift
//  YHNews
//
//  Created by Jason Wang on 2/14/23.
//

import Foundation

protocol Executable: Requestable, ResponseMapper {
    @discardableResult
    func executeRequest(queue: DispatchQueue,
                        session: URLSession,
                        completion: @escaping (Result<Data, APIError>) -> Void) -> URLSessionDataTask?
}

extension Executable {
    @discardableResult
    func executeRequest(queue: DispatchQueue = .main,
                        session: URLSession = .shared,
                        completion: @escaping (Result<Data, APIError>) -> Void) -> URLSessionDataTask? {
        guard let validURL = url else {
            completion(.failure(.invalidURL))
            return nil
        }

        var request = URLRequest(url: validURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header

        if let body = body {
            do {
                let dataBody = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = dataBody
            }
            catch {
                completion(.failure(.invalidJSONBody))
            }
        }

        return session.dataTask(with: request) { (data, response, err) in
            let resultResponse = self.parseHTTPReponse((data, (response as? HTTPURLResponse), err))
            queue.async {
                completion(resultResponse)
            }
        }
    }
}

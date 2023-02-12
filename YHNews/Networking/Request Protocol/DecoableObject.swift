//
//  ViewController.swift
//  YHNews
//
//  Created by Jason Wang on 2/11/23.
//

import Foundation

protocol DecodableObject {
    static func decode<T: Decodable>(_ object: T.Type ,from data: Data) -> Result<T, APIError>
}

extension DecodableObject {
    static func decode<T: Decodable>(_ object: T.Type ,from data: Data) -> Result<T, APIError> {
        do {
            let object = try JSONDecoder().decode(object, from: data)
            return .success(object)
        } catch {
            return .failure(.decode("\(T.self)"))
        }
    }
}

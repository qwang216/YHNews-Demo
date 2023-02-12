//
//  ViewController.swift
//  YHNews
//
//  Created by Jason Wang on 2/11/23.
//

import Foundation

enum APIError {
    case invalidURL
    case invalidJSONBody
    case statusCode(Int?)
    case invalidData
    case decode(String)
}

extension APIError: Error {
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidJSONBody:
            return "Invalid JSON Body"
        case .statusCode(let code):
            return "Statud Code: \(code ?? -1)"
        case .invalidData:
            return "Invalid Data Response"
        case .decode(let object):
            return "Failed on Decoding: \(object)"
        }

    }
}

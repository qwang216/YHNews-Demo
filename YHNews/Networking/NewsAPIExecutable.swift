//
//  ViewController.swift
//  YHNews
//
//  Created by Jason Wang on 2/11/23.
//

import Foundation

struct NYTAPIConstant {
    static let apiKey = "tll3FdJtVIbk1snPkGcF5ZffNP2ktLhy"
}

enum NewsAPIError: Error {
    case apiNetworkError
}

protocol NewsAPIExecutable: Requestable, ExecuteDecodable {}
extension NewsAPIExecutable {
    var scheme: String {
        "https"
    }
    var baseURL: String {
        "api.nytimes.com"
    }
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "api-key", value: NYTAPIConstant.apiKey)]
    }
    var body: JSON? {
        nil
    }
    var header: HTTPHeader? {
        nil
    }
    var method: HTTPMethod {
        .GET
    }
}

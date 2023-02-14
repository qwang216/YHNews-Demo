//
//  ViewController.swift
//  YHNews
//
//  Created by Jason Wang on 2/11/23.
//

import Foundation

protocol Requestable {
    var scheme: String { get }
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var relativePath: String { set get }
    var url: URL? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: JSON? { get }
    var header: HTTPHeader? { get }
}

extension Requestable {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL
        urlComponents.path = relativePath
        if let items = queryItems {
            urlComponents.queryItems = items
        }
        return urlComponents.url
    }

}

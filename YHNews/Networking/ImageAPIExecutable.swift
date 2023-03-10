//
//  ViewController.swift
//  YHNews
//
//  Created by Jason Wang on 2/11/23.
//

import Foundation

protocol ImageAPIExecutable: Requestable {
    var absoluteURLString: String { get set }
}
extension ImageAPIExecutable {
    var url: URL? {
        URL(string: absoluteURLString)
    }
    var method: HTTPMethod {
        .GET
    }
    var baseURL: String {
        ""
    }
    var header: HTTPHeader? {
        nil
    }
    var scheme: String {
        ""
    }
    var queryItems: [URLQueryItem]? {
        nil
    }
    var body: JSON? {
        nil
    }
}

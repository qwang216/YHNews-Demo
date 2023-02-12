//
//  ViewController.swift
//  YHNews
//
//  Created by Jason Wang on 2/11/23.
//

import Foundation

protocol ResponseMapper {
    func parseHTTPReponse(_ apiResponse: APIResponse) -> Result<Data, APIError>
}

extension ResponseMapper {
    func parseHTTPReponse(_ apiResponse: APIResponse) -> Result<Data, APIError> {
        guard let response = apiResponse.response, 200...299 ~= response.statusCode else {
            return .failure(.statusCode(apiResponse.response?.statusCode))
        }
        guard let validData = apiResponse.data else { return .failure(.invalidData) }
        return .success(validData)
    }
}

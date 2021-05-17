//
//  URLSession+Result.swift
//  Payoneer
//
//  Created by Vishal on 14/05/21.
//

import Foundation

typealias URLSessionNetworkResult = Result<Data, Error>

protocol UrlSessionProtocol {
    func get(request: URLRequest, result: @escaping (URLSessionNetworkResult) -> Void)
}

extension URLSession: UrlSessionProtocol {
    
    private func getResult(data: Data?, response: URLResponse?, error: Error?) -> URLSessionNetworkResult {
        switch (data, response, error) {
            
            case let (_, _, error?):
                return .failure(error)
                
            // has data but might have error
            case let (data?, response as HTTPURLResponse, _)
                    where NetworkError.from(httpCode: response.statusCode) == .none:
                return .success(data)
                
            // has data but have error
            case let (_, response as HTTPURLResponse, .none):
                return .failure(NetworkError.from(httpCode: response.statusCode) ?? NetworkError.unknown)
                
            case (_, _, .none):
                return .failure(NetworkError.noResponse)
        }
    }
    
    func get(request: URLRequest, result: @escaping (URLSessionNetworkResult) -> Void) {
        dataTask(with: request) { data, response, error in
            
            result(self.getResult(data: data, response: response, error: error))
            
        }.resume()
    }
}

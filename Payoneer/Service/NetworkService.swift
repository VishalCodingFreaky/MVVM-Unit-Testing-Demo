//
//  PaymentListService.swift
//  Payoneer
//
//  Created by Vishal on 14/05/21.
//

import Foundation


typealias ResultType = Result<Any,Error>
typealias ResultClosure = (ResultType) -> Void

protocol NetworkServiceProtocol {
     static func fetch<DataType: Decodable>( name:NetworkServiceName?, completion: @escaping (Result<DataType, Error>) -> ())
}

struct NetworkService:NetworkServiceProtocol {
     static func fetch<DataType: Decodable>( name:NetworkServiceName?, completion: @escaping (Result<DataType, Error>) -> ()) {
        guard let request = name?.request else {
            completion(.failure(NetworkError.unableToCreateURLRequest))
            return
        }
        URLSession.shared.get(request: request) { result in
            switch result {
                case .success(let data):
                    if let model = try? JSONDecoder().decode(DataType.self, from: data) {
                        completion(.success(model))
                    }else {
                        completion(.failure(NetworkError.unableToParseData))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

enum NetworkServiceName {
    case payment
    case method
    
    var request: URLRequest? {
        var path = ""
        switch self {
            case .payment:
                path = Constants.Urls.payment
            case .method:
                break
        }
        if let url = URL(string: Constants.Urls.base + path) {
            return URLRequest(url: url)
        }
        return nil
    }
}


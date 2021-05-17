//
//  NetworkMockService.swift
//  PayoneerTests
//
//  Created by Vishal on 17/05/21.
//

import Foundation
@testable import Payoneer

// Mock Service
struct NetworkMockService:NetworkServiceProtocol {
     static func fetch<DataType: Decodable>( name:NetworkServiceName?, completion: @escaping (Result<DataType, Error>) -> ()) {
        switch name {
        case .payment:
            completion(.success(.parse(jsonFile: "paymentList")!))
        default:
            completion(.failure(NetworkError.unableToParseData))
        }
    }
}

// Parse Local Json
extension Decodable {
  static func parse(jsonFile: String) -> Self {
    guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let output = try? JSONDecoder().decode(self, from: data)
        else {
        return self as! Self
    }
    return output
  }
}

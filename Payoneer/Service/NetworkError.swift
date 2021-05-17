//
//  NetworkError.swift
//  Payoneer
//
//  Created by Vishal on 14/05/21.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noResponse
    case invalidCredentials
    case clientError
    case serverError
    case unknown
    case unableToParseData
    case unableToCreateURLRequest
    
    static func from(httpCode: Int) -> NetworkError? {
        switch httpCode {
            case 200...299, 300...399:
                return .none
            case 400, 401:
                return .invalidCredentials
            case 402...499:
                return .clientError
            case 500...599:
                return .serverError
            default:
                return .unknown
        }
    }
}

extension NetworkError : LocalizedError {
    var errorDescription: String? {
        var msg = ""
        switch self {
            case .invalidURL:
                break
            case .noResponse:
                break
            case .invalidCredentials:
                msg = "Unable to parse data!"
                break
            case .clientError:
                msg = "Please try again later!"
                break
            case .serverError:
                msg = "Server down. Please try again later!"
                break
            case .unknown:
                break
            // Other erros
            case .unableToParseData:
                msg = "Unable to parse data!"
                break
            case .unableToCreateURLRequest:
                break
        }
        return msg
    }
}

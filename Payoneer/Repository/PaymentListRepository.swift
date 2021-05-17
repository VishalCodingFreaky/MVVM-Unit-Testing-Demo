//
//  PaymentListRepository.swift
//  Payoneer
//
//  Created by Vishal on 14/05/21.
//

import Foundation

// Payment List Repository Protocol
protocol PaymentListRepositoryProtocol {
    func getPaymentListData(name: NetworkServiceName, result: @escaping ResultClosure)
}

// Payment List Repository
class PaymentListRepository: PaymentListRepositoryProtocol {

    // Get Payment List Data
    func getPaymentListData(name: NetworkServiceName, result: @escaping ResultClosure) {
        NetworkService.fetch(name: name) { (_result: Result<PaymentListModel, Error>) in
            switch _result {
                case .success(let model):
                    result(.success(model))
                case .failure(let error):
                    result(.failure(error))
            }
        }
    }
}

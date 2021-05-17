//
//  PaymentListMockRepository.swift
//  PayoneerTests
//
//  Created by Vishal on 17/05/21.
//

@testable import Payoneer

// Payment List Mock Repository
class PaymentListMockRepository: PaymentListRepositoryProtocol {

    // Get Payment List Data
    func getPaymentListData(name: NetworkServiceName, result: @escaping ResultClosure) {
        NetworkMockService.fetch(name: name) { (_result: Result<PaymentListModel, Error>) in
            switch _result {
                case .success(let model):
                    result(.success(model))
                case .failure(let error):
                    result(.failure(error))
            }
        }
    }
}

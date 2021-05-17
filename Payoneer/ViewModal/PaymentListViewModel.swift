//
//  AppDelegate.swift
//  Payoneer
//
//  Created by Vishal on 12/05/21.
//

import UIKit

// Input Protocols
protocol PaymentListInputViewModel {
    func getPaymentMethodList(name: NetworkServiceName)
}

// Output Protocols
protocol PaymentListOutputViewModel {
    func getDataForRows(indexPath: IndexPath) -> (name: String,imageUrl: String)
    func getNumberOfRows(section: Int) -> Int
    func getHeightOfRows() -> CGFloat
    func getErrorMessage() -> String
    var  showError:Dynamic<Bool> { get }
    var  reloadTable: Dynamic<Bool> { get }
}

protocol PaymentListViewModelType: PaymentListInputViewModel, PaymentListOutputViewModel {
    var input: PaymentListInputViewModel { get }
    var output: PaymentListOutputViewModel { get }
}

class PaymentListViewModel: PaymentListViewModelType {
    
    // Objects
    var input: PaymentListInputViewModel { return self }
    var output: PaymentListOutputViewModel { return self }
    
    private var repository:PaymentListRepositoryProtocol
    var paymentList: PaymentListModel?
    var errorMsg: String?
    var reloadTable: Dynamic<Bool> = Dynamic(false)
    var showError: Dynamic<Bool> = Dynamic(false)
    
    // initialize
    init(repository:PaymentListRepositoryProtocol = PaymentListRepository()){
        self.repository = repository
    }
    
    // Get Number Of Rows
    func getNumberOfRows(section: Int) -> Int {
        return self.paymentList?.networks.applicable.count ?? 0
    }
    
    // Get Height Of Rows
    func getHeightOfRows() -> CGFloat {
        return 90
    }
    
    // Get Error Message
    func getErrorMessage() -> String {
        return self.errorMsg ?? ""
    }

    // Get Data for Cell Rows
    func getDataForRows(indexPath: IndexPath) -> (name: String,imageUrl: String) {
        let dataModel = self.paymentList?.networks.applicable[indexPath.row]
        return (dataModel?.label ?? "",dataModel?.links.logo ?? "")
    }
    
    // Get Payment Method List
    func getPaymentMethodList(name: NetworkServiceName) {
        repository.getPaymentListData(name: name) { [weak self] (result) in
            switch result  {
                case .success(let model):
                    if let model = model as? PaymentListModel {
                        self?.paymentList = model
                        self?.reloadTable.value = true
                    }
                case .failure(let error):
                    let errorMessage = error is NetworkError ? (error as! NetworkError).errorDescription : error.localizedDescription
                    self?.errorMsg = errorMessage
                    self?.showError.value = true
            }
        }
    }
}



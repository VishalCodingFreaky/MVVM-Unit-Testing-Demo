//
//  PaymentListViewModelTest.swift
//  PayoneerTests
//
//  Created by Vishal on 17/05/21.
//

import XCTest
@testable import Payoneer

class PaymentListViewModelTest: XCTestCase {

    // Objects
    var viewModel: PaymentListViewModel!
    var mockRepository:PaymentListMockRepository!
    
    override func setUp() {
        mockRepository = PaymentListMockRepository()
        viewModel = .init(repository: mockRepository)
    }
   
    // Payment method Success
    func testPaymentMehtodListSuccess() {
        viewModel.getPaymentMethodList(name: .payment)
        XCTAssertNotNil(viewModel.paymentList)
        XCTAssertGreaterThan(viewModel.getNumberOfRows(section: 0), 0)
        XCTAssertGreaterThan(viewModel.getHeightOfRows(), 0)
        XCTAssertTrue(viewModel.reloadTable.value)
    }
    
    // Payment method Failure
    func testPaymentMehtodListFailure() {
        viewModel.getPaymentMethodList(name: .method)
        XCTAssertNotNil(viewModel.getErrorMessage())
        XCTAssertEqual(viewModel.getErrorMessage(), "Unable to parse data!")
    }
}



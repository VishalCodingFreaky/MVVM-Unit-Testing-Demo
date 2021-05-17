//
//  AppDelegate.swift
//  Payoneer
//
//  Created by Vishal on 12/05/21.
//

import UIKit

class PaymentListViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    //Objects
    var viewModal: PaymentListViewModelType = PaymentListViewModel()
    
    // ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // SetUp UI
    private func setUpUI(){
        self.showLoading()
        viewModal.input.getPaymentMethodList(name: .payment)
        setUpTableView()
        closureSetup()
    }
    
    // SetUp TableView
    private func setUpTableView() {
        tblView.register(UINib(nibName: Constants.Identifiers.paymentListCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.paymentListCell)
    }

    ///Closure SetUp
    private func closureSetup() {
        // Reload Data
        viewModal.output.reloadTable.bind {[weak self] (_) in
                self?.hideLoading()
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
        
        // Show Error
        viewModal.output.showError.bind { [self] (_) in
            DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                self.showAlert(withMessage: viewModal.output.getErrorMessage())
            })}
        }
    }
}

// TableView Delegate and Data Source
extension PaymentListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.output.getNumberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.paymentListCell, for: indexPath) as? PaymentListCell {
            let cellData = viewModal.output.getDataForRows(indexPath: indexPath)
            cell.setData(name: cellData.name, imageUrl: cellData.imageUrl)
            return cell
            }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModal.output.getHeightOfRows()
    }
}

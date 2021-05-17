//
//  Extensions.swift
//  Payoneer
//
//  Created by Vishal on 15/05/21.
//

import UIKit

// Image load extension
extension UIImageView {
    func displayImageFrom(link:String, contentMode: UIView.ContentMode) {
        guard let url = NSURL(string:link) as URL? else { return }
        URLSession.shared.dataTask( with: url, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

extension  UIViewController {
    // Show text alert
    func showAlert(withTitle title: String? = Constants.Alert.title, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: Constants.Alert.buttonTitleOk, style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    // Show Loading
    func showLoading() {
        let alert = UIAlertController(title: nil, message: Constants.Alert.loading, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    // Hide Loading
    func hideLoading() {
        DispatchQueue.main.async(execute: {
            self.dismiss(animated: false, completion: nil)
        })
    }
}

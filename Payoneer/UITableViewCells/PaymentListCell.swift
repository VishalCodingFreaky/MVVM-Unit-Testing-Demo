//
//  SendTextImageCel.swift
//  ezBlast
//
//  Created by Mac Book Air on 29/07/20.
//  Copyright © 2020 Shanisoffice. All rights reserved.
//

import UIKit

class PaymentListCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var iconImgVw: UIImageView!
    
    // Set Data Values
    func setData(name: String, imageUrl: String) {
        nameLbl.text = name
        iconImgVw.image = #imageLiteral(resourceName: "PlaceHolderImage")
        iconImgVw.displayImageFrom(link: imageUrl, contentMode: .scaleAspectFit)
    }
}

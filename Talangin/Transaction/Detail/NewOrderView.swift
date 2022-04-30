//
//  OrderViewCell.swift
//  Talangin
//
//  Created by zy on 29/04/22.
//

import UIKit

class OrderViewCell: UIView {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var amount: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
        xibSetup()
        name.layer.cornerRadius = 8.0;
        name.layer.masksToBounds = true;
        name.layer.borderColor = UIColor.black.cgColor;
        name.layer.borderWidth = 0.5;
        
        price.layer.cornerRadius = 8.0;
        price.layer.masksToBounds = true;
        price.layer.borderColor = UIColor.black.cgColor;
        price.layer.borderWidth = 0.5;
        
        quantity.layer.cornerRadius = 8.0;
        quantity.layer.masksToBounds = true;
        quantity.layer.borderColor = UIColor.black.cgColor;
        quantity.layer.borderWidth = 0.5;
        
        amount.layer.cornerRadius = 8.0;
        amount.layer.masksToBounds = true;
        amount.layer.borderColor = UIColor.black.cgColor;
        amount.layer.borderWidth = 0.5;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

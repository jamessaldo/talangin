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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

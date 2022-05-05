//
//  OrderViewCell.swift
//  Talangin
//
//  Created by zy on 29/04/22.
//

import UIKit

class MemberOrder: UIView {
    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    var data: OrderModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

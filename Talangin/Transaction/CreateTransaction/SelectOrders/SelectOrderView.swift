//
//  SelectOrderView.swift
//  Talangin
//
//  Created by zy on 29/04/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol SelectOrderViewDelegate: AnyObject {
    // Delegate method that can be used
}

class SelectOrderView: UITableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    
    var contact: OrderModel?
    // MARK: - delegate object initialization
    weak var delegate: SelectOrderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        accessoryType = selected ? .checkmark : .none
    }
}

//
//  MemberTransactionView.swift
//  Talangin
//
//  Created by zy on 29/04/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol MemberTransactionViewDelegate: AnyObject {
    // Delegate method that can be used
}

class MemberTransactionView: UITableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    // MARK: - delegate object initialization
    weak var delegate: MemberTransactionViewDelegate?
    
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

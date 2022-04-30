//
//  NewTransactionView.swift
//  Talangin
//
//  Created by zy on 29/04/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol NewTransactionViewDelegate: AnyObject {
    // Delegate method that can be used
    func addMoreRow()
}

class NewTransactionView: UITableViewCell {
    
    @IBOutlet weak var addMore: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - delegate object initialization
    weak var delegate: NewTransactionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addMoreAction(_ sender: UIButton) {
        self.delegate?.addMoreRow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//
//  NewTransactionView.swift
//  Talangin
//
//  Created by zy on 29/04/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol MemberOrderTransactionViewDelegate: AnyObject {
    // Delegate method that can be used
    func addMoreRow(indexPerson: Int)
}

class MemberOrderTransactionView: UITableViewCell {
    
    @IBOutlet weak var addMore: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var personName: UILabel!
    
    // MARK: - delegate object initialization
    weak var delegate: MemberOrderTransactionViewDelegate?
    var contact: ContactModel = ContactModel()
    var indexPerson: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addMoreAction(_ sender: UIButton) {
        self.delegate?.addMoreRow(indexPerson: self.indexPerson ?? 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

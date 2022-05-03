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
    func addMoreRow()
}

class MemberTransactionView: UITableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    // MARK: - delegate object initialization
    weak var delegate: MemberTransactionViewDelegate?
    
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
        accessoryType = selected ? .checkmark : .none
    }
    
//    override var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set (newFrame) {
//            var frame = newFrame
//            if self.accessoryType == .none {
//                frame.size.width -= 20
//            }
//            super.frame = frame
//        }
//    }
    
}

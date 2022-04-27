//
//  DetailCell.swift
//  Talangin
//
//  Created by zy on 27/04/22.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var transactionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

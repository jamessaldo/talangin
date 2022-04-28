//
//  DetailViewCell.swift
//  Talangin
//
//  Created by zy on 27/04/22.
//

import UIKit

class DetailViewCell: UITableViewCell {
    
    
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

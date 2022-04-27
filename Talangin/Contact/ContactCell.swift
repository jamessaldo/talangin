//
//  ContactCell.swift
//  My Diary
//
//  Created by zy on 27/04/22.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var contactName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

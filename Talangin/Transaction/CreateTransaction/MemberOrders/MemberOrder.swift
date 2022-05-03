//
//  OrderViewCell.swift
//  Talangin
//
//  Created by zy on 29/04/22.
//

import UIKit

class MemberOrder: UIView, UITextFieldDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var amount: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
        xibSetup()
        name.layer.cornerRadius = 8.0;
        name.layer.masksToBounds = true;
        name.layer.borderColor = UIColor.black.cgColor;
        name.layer.borderWidth = 0.3;
        
        price.layer.cornerRadius = 8.0;
        price.layer.masksToBounds = true;
        price.layer.borderColor = UIColor.black.cgColor;
        price.layer.borderWidth = 0.3;
        
        quantity.layer.cornerRadius = 8.0;
        quantity.layer.masksToBounds = true;
        quantity.layer.borderColor = UIColor.black.cgColor;
        quantity.layer.borderWidth = 0.3;
        
        amount.layer.cornerRadius = 8.0;
        amount.layer.masksToBounds = true;
        amount.layer.borderColor = UIColor.black.cgColor;
        amount.layer.borderWidth = 0.3;
        
        name.delegate = self
        price.delegate = self
        quantity.delegate = self
        amount.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == name {
            name.text = ""
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == price && price.text == "0" {
            price.text = ""
        }
        
        if textField == quantity && quantity.text == "0" {
            quantity.text = ""
        }
        
        if textField == amount && amount.text == "0" {
            amount.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            // Since our textview text it's an optional, which possible to have a nil, then we need to use it savely
            if let storyHasSomething = name.text {
                print(storyHasSomething)
            }
            name.resignFirstResponder()
            return false
        }
        return true
    }
}

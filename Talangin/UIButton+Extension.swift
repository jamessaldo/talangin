//
//  UIButton+Extension.swift
//  My Diary
//
//  Created by zein rezky chandra on 06/04/22.
//

import UIKit

extension UIButton {
    func drawACircle() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.layer.frame.width/2
    }
    
    func drawARoundedCorner() {
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }

    func drawABorder() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0
    }
    
}

//
//  MaxLength.swift
//  monikers
//
//  Created by Jason Hoang on 4/2/18.
//  Copyright © 2018 Jason Hoang. All rights reserved.
//

// Check max length on Storyboard of UITextfield 
// found on: https://stackoverflow.com/questions/31363216/set-the-maximum-character-length-of-a-uitextfield-in-swift?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa

import UIKit
private var __maxLengths = [UITextField: Int]()

extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
}

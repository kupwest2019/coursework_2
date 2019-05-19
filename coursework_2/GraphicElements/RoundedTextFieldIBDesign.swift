//
//  RoundedTextFieldIBDesign.swift
//  coursework_2
//
//  Copyright © 2019 group_a. All rights reserved.
//

import Foundation
import UIKit

/*
 Rounded Custom Textfield
 */

@IBDesignable class RoundTextField : UITextField {
    
    @IBInspectable var rounded: Bool = false {
        willSet{
            if newValue{
                self.layer.cornerRadius = self.frame.size.height / 2
            }
            else {
                self.layer.cornerRadius = 0
            }
        }
        
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    /*
     @IBInspectable var shadowOffset: Float = 0 {
     didSet {
     layer.shadowOffset = shadowOffset
     }
     }
     */
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    
    
}

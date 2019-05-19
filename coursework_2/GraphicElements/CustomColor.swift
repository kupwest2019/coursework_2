//
//  CustomColor.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import Foundation
import UIKit

/*
 Extension of UIColor Class to have a better way to define a color based on its value (:
 */

extension UIColor{
    convenience init(rgb: UInt, alphaVal: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alphaVal
        )
    }
}

struct MyCustomColors{
    let light_yellow = UIColor(rgb: 0xFCFBE3, alphaVal: 1.0)
    let light_orange = UIColor(rgb: 0xF8B500, alphaVal: 1.0)
    let green = UIColor(rgb: 0x00ADB5, alphaVal: 1.0)
    let orange = UIColor(rgb: 0xFC7F62, alphaVal: 1.0)
    let blue = UIColor(rgb: 0x32405C, alphaVal: 1.0)
    let darkBrown = UIColor(rgb: 0x400101, alphaVal: 1.0)
    let red  = UIColor(rgb: 0xD93D04, alphaVal: 1.0)
    let purple =  UIColor(rgb: 0x5010DD, alphaVal: 1.0)
    
    
    let category_light_orange = UIColor(rgb: 0xF4E4BD, alphaVal: 1)
    let category_green = UIColor(rgb: 0xACCCCC, alphaVal: 1)
    let category_red = UIColor(rgb: 0xEAC7C1, alphaVal: 1)
    let category_blue = UIColor(rgb: 0xB3C3DD, alphaVal: 1)
    
     let light_yellow_trans = UIColor(rgb: 0xFCFBE3, alphaVal: 0.1)
    
    
    
}


struct MyBarTabColors{
    let light_yellow = UIColor(rgb: 0xFCFBE3, alphaVal: 1.0)

}

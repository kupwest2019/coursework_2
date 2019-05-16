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
}

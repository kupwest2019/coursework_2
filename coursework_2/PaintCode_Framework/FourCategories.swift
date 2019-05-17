//
//  FourCategories.swift
//  coursework_2
//
//  Created by Tiziano on 17/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

@IBDesignable
class FourCategories: UIView {
    
    private var blue : CGFloat  = 0.0
    var completedblue : CGFloat {
        set (newProgress){
            if (newProgress>1){
                blue = 1
            }
            if (newProgress<0){
                blue = 0
            }
            
            blue = newProgress
            setNeedsDisplay()
        }
        get {
            return blue
        }
    }
    
    private var green : CGFloat  = 0.0
    var completedgreen : CGFloat {
        set (newProgress){
            if (newProgress>1){
                green = 1
            }
            if (newProgress<0){
                green = 0
            }
            
            green = newProgress
            setNeedsDisplay()
        }
        get {
            return green
        }
    }
    
    private var red : CGFloat  = 0.0
    var completedred : CGFloat {
        set (newProgress){
            if (newProgress>1){
                red = 1
            }
            if (newProgress<0){
                red = 0
            }
            
            red = newProgress
            setNeedsDisplay()
        }
        get {
            return red
        }
    }
    private var yellow : CGFloat  = 0.0
    var completedyellow : CGFloat {
        set (newProgress){
            if (newProgress>1){
                yellow = 1
            }
            if (newProgress<0){
                yellow = 0
            }
            
            yellow = newProgress
            setNeedsDisplay()
        }
        get {
            return yellow
        }
    }
    
    override func draw(_ rect: CGRect) {
        CategoryColors.drawCanvas1(frame: bounds, resizing: .aspectFit, blueCategory: blue, greenCategory: green, orangeCategory: red, yellowCategory: yellow)

        
    }
    
}

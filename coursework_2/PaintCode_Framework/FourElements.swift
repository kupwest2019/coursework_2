//
//  FourElements.swift
//  coursework_2
//
//  Copyright © 2019 group_a. All rights reserved.
//  // IBDesignable for the BMI animation

import UIKit

@IBDesignable
class ForElements: UIView {
    
    private var numberOfActivityToDo : CGFloat  = 0.0
    var prgress : CGFloat {
        set (newProgress){
            if newProgress > 1{
                numberOfActivityToDo = newProgress
            }
            else if newProgress < 0{
                numberOfActivityToDo = newProgress
            }
            else{
                numberOfActivityToDo = newProgress
            }
            print(numberOfActivityToDo)
            setNeedsDisplay()
        }
        get {
            return numberOfActivityToDo
        }
    }
    
    override func draw(_ rect: CGRect) {
        BmiChart.drawCanvas1(frame: bounds, resizing: .aspectFit, bmi: prgress)
    }
    
}

//
//  Stopwatch.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

@IBDesignable
class Stopwatch: UIView {
    
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
        Test1.drawCanvas1(frame: bounds, resizing: .aspectFit, innerProgress: numberOfActivityToDo)
    }
    
}

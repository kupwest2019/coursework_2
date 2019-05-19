//
//  TrackerChart.swift
//  coursework_2
//
//  Copyright © 2019 group_a. All rights reserved.
//  IBDesignable for the Tracker animation 

import UIKit

@IBDesignable
class TrackerChart: UIView {
    
    private var completed : CGFloat  = 0.0
    var completedActivities : CGFloat {
        set (newProgress){
            if (newProgress>1){
                completed = 1
            }
            if (newProgress<0){
                completed = 0
            }
            
            completed = newProgress
            setNeedsDisplay()
        }
        get {
            return completed
        }
    }
    
    private var notCompleted : CGFloat  = 0.0
    var notCompletedActivities : CGFloat {
        set (newProgress){
            if (newProgress>1){
                notCompleted = 1
            }
            if (newProgress<0){
                notCompleted = 0
            }
            notCompleted = newProgress
            setNeedsDisplay()
        }
        get {
            return notCompleted
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        Trackertask.drawCanvas1(frame: bounds, resizing: .aspectFit, failure: notCompleted, achive: completed)
        
    }
    
}

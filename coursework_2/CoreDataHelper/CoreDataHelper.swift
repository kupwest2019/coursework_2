//
//  CoreDataHelper.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

struct Category_obj{
    var color : String = ""
    var name : String = ""
    var goal : String = ""
}
    

struct Calendar_Day_Activity{
    var activities_scheduled : [Activity] = []
    var day_number : Int = 0
    init(day : Int) {
        day_number = day
    }
}



struct Activity_obj {
    var name : String?
    var category : String?
    var start_date: Date?
    var not_infinite : Bool?
    var end_date: Date?
    var duration : Int?
    var time : String?
    var time_choice : Bool?
    var duration_choice : Bool?

    
    ///--
    var mon_trigger:Bool = false
    var tue_trigger:Bool = false
    var wed_trigger:Bool = false
    var thr_trigger:Bool = false
    var fri_trigger:Bool = false
    var sat_trigger:Bool = false
    var sun_trigger:Bool = false
    var daily_trigger:Bool = false
    var week_trigger:Bool = false
    var month_trigger:Bool = false
}

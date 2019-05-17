//
//  NewActivity_Recurrency_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class NewActivity_Recurrency_ViewController: UIViewController {

    let myColor : MyCustomColors = MyCustomColors()
    var new_activity : Activity_obj?
    var daysInAWeek : [RoundButtonDesignable] = []

    var oldActivity : Activity?
    var editing_mode_on: Bool = false
    
    // bool
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

    //var
//    @IBOutlet weak var month: UIButton!
//    @IBOutlet weak var week: UIButton!
//    @IBOutlet weak var day: UIButton!
//    @IBOutlet weak var mon: UIButton!
//    @IBOutlet weak var tue: UIButton!
//    @IBOutlet weak var wed: UIButton!
//    @IBOutlet weak var thr: UIButton!
//    @IBOutlet weak var fri: UIButton!
//    @IBOutlet weak var sat: UIButton!
//    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var month: RoundButtonDesignable!
    @IBOutlet weak var week: RoundButtonDesignable!
    
    @IBOutlet weak var day: RoundButtonDesignable!
    @IBOutlet weak var mon: RoundButtonDesignable!
    @IBOutlet weak var tue: RoundButtonDesignable!
    @IBOutlet weak var wed: RoundButtonDesignable!
    
    @IBOutlet weak var thr: RoundButtonDesignable!
    @IBOutlet weak var fri: RoundButtonDesignable!
    @IBOutlet weak var sat: RoundButtonDesignable!
    @IBOutlet weak var sun: RoundButtonDesignable!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        daysInAWeek.append(mon)
        daysInAWeek.append(tue)
        daysInAWeek.append(wed)
        daysInAWeek.append(thr)
        daysInAWeek.append(fri)
        daysInAWeek.append(sat)
        daysInAWeek.append(sun)
        
        
        weekDisable()
        
        if (self.editing_mode_on){
            
            updateFromOld()
        }
        // Do any additional setup after loading the view.
    }

    
    //func
    @IBAction func button_month(_ sender: Any) {
        
            month_trigger = true
            month.backgroundColor = myColor.light_yellow
            month.borderColor = myColor.orange
            month.shadowRadius = 1
            month.shadowOpacity = 2
            month.borderWidth = 3
        
        setFalseByMonth()
        weekDisable()
        
    }
    @IBAction func button_week(_ sender: Any) {
        
            week_trigger = true
            week.backgroundColor = myColor.light_yellow
            week.borderColor = myColor.orange
            week.shadowRadius = 1
            week.shadowOpacity = 2
            week.borderWidth = 3
        
//        else{
//            week_trigger = false
//            week.backgroundColor = UIColor.white
//
//        }
        setFalseByWeek()
        weekEnable()
    }
    @IBAction func button_day(_ sender: Any) {
        
            daily_trigger = true
            day.backgroundColor = myColor.light_yellow
            day.borderColor = myColor.orange
            day.shadowRadius = 1
            day.shadowOpacity = 2
            day.borderWidth = 3
        
//        else{
//            daily_trigger = false
//            day.backgroundColor = UIColor.white
//        }
        setFalseByDay()
        weekDisable()
    }
    
    
    
    func setFalseByDay(){
//        mon_trigger = false
//        tue_trigger = false
//        wed_trigger = false
//        thr_trigger = false
//        fri_trigger = false
//        sat_trigger = false
//        sun_trigger = false
        
        
       // daily_trigger = false
        week_trigger = false
        month_trigger = false
        
        week.backgroundColor = UIColor.white
        week.borderWidth = 1
        week.borderColor = UIColor.red
        week.shadowRadius = 0
        week.shadowOpacity = 0
        month.backgroundColor = UIColor.white
        month.borderWidth = 1
        month.borderColor = UIColor.red
        month.shadowRadius = 0
        month.shadowOpacity = 0
    }
    
    
    func weekDaysFalse(){
                mon_trigger = false
                tue_trigger = false
                wed_trigger = false
                thr_trigger = false
                fri_trigger = false
                sat_trigger = false
                sun_trigger = false
    }
    
    func setFalseByWeek(){
//        mon_trigger = false
//        tue_trigger = false
//        wed_trigger = false
//        thr_trigger = false
//        fri_trigger = false
//        sat_trigger = false
//        sun_trigger = false
        
        
        daily_trigger = false
        //week_trigger = false
        month_trigger = false
        
        day.backgroundColor = UIColor.white
        day.borderWidth = 1
        day.borderColor = UIColor.red
        day.shadowRadius = 0
        day.shadowOpacity = 0
        
        month.backgroundColor = UIColor.white
        month.borderWidth = 1
        month.borderColor = UIColor.red
        month.shadowRadius = 0
        month.shadowOpacity = 0
        
    }
    
    func setFalseByMonth(){
//        mon_trigger = false
//        tue_trigger = false
//        wed_trigger = false
//        thr_trigger = false
//        fri_trigger = false
//        sat_trigger = false
//        sun_trigger = false
        
        
        daily_trigger = false
        week_trigger = false
        //month_trigger = false
        day.backgroundColor = UIColor.white
        day.borderWidth = 1
        day.borderColor = UIColor.red
        day.shadowRadius = 0
        day.shadowOpacity = 0
        week.backgroundColor = UIColor.white
        week.borderWidth = 1
        week.borderColor = UIColor.red
        week.shadowRadius = 0
        week.shadowOpacity = 0
    }
    
    func weekDisable(){
        
        for day in daysInAWeek{
            day.isEnabled = false
            day.backgroundColor = UIColor.white
            day.borderWidth = 1
            day.borderColor = UIColor.red
            day.shadowRadius = 0
            day.shadowOpacity = 0
        }

    }
    
    
    
    
    
    
    
    func weekEnable(){
        
        

        for day in daysInAWeek{
            day.isEnabled = true
        }
        
     
        
        
        if mon_trigger == true {
            mon.backgroundColor = myColor.light_yellow
            mon.borderColor = myColor.orange
            mon.shadowRadius = 1
            mon.shadowOpacity = 2
            mon.borderWidth = 3
        }
        if tue_trigger == true {
            tue.backgroundColor = myColor.light_yellow
            tue.borderColor = myColor.orange
            tue.shadowRadius = 1
            tue.shadowOpacity = 2
            tue.borderWidth = 3
            
        }
        
        if wed_trigger == true {
            wed.backgroundColor = myColor.light_yellow
            wed.borderColor = myColor.orange
            wed.shadowRadius = 1
            wed.shadowOpacity = 2
            wed.borderWidth = 3
            
        }
        
        if thr_trigger == true {
            thr.backgroundColor = myColor.light_yellow
            thr.borderColor = myColor.orange
            thr.shadowRadius = 1
            thr.shadowOpacity = 2
            thr.borderWidth = 3
            
        }
        
        if fri_trigger == true {
            fri.backgroundColor = myColor.light_yellow
            fri.borderColor = myColor.orange
            fri.shadowRadius = 1
            fri.shadowOpacity = 2
            fri.borderWidth = 3
            
        }
        
        if sat_trigger == true {
            sat.backgroundColor = myColor.light_yellow
            sat.borderColor = myColor.orange
            sat.shadowRadius = 1
            sat.shadowOpacity = 2
            sat.borderWidth = 3
            
        }
        
        if sun_trigger == true {
            sun.backgroundColor = myColor.light_yellow
            sun.borderColor = myColor.orange
            sun.shadowRadius = 1
            sun.shadowOpacity = 2
            sun.borderWidth = 3
            
        }
        

    }
    
    @IBAction func button_mon(_ sender: Any) {
        if (mon_trigger == false){
            mon_trigger = true
            mon.backgroundColor = myColor.light_yellow
            mon.borderColor = myColor.orange
            mon.shadowRadius = 1
            mon.shadowOpacity = 2
            mon.borderWidth = 3
            
        }
        else{
           mon_trigger = false
           mon.backgroundColor = UIColor.white
           mon.borderWidth = 1
           mon.borderColor = UIColor.red
           mon.shadowRadius = 0
           mon.shadowOpacity = 0
        }
    }
    
    @IBAction func button_tue(_ sender: Any) {
        if (tue_trigger == false){
            tue_trigger = true
            tue.backgroundColor = myColor.light_yellow
            tue.borderColor = myColor.orange
            tue.shadowRadius = 1
            tue.shadowOpacity = 2
            tue.borderWidth = 3
        }
        else{
            tue_trigger = false
            tue.backgroundColor = UIColor.white
            tue.borderWidth = 1
            tue.borderColor = UIColor.red
            tue.shadowRadius = 0
            tue.shadowOpacity = 0
        }
    }
    
    @IBAction func button_wed(_ sender: Any) {
        if (wed_trigger == false){
            wed_trigger = true
            wed.backgroundColor = myColor.light_yellow
            wed.borderColor = myColor.orange
            wed.shadowRadius = 1
            wed.shadowOpacity = 2
            wed.borderWidth = 3
        }
        else{
            wed_trigger = false
            wed.backgroundColor = UIColor.white
            wed.borderWidth = 1
            wed.borderColor = UIColor.red
            wed.shadowRadius = 0
            wed.shadowOpacity = 0
        }
    }
    
    @IBAction func button_thr(_ sender: Any) {
        if (thr_trigger == false){
            thr_trigger = true
            thr.backgroundColor = myColor.light_yellow
            thr.borderColor = myColor.orange
            thr.shadowRadius = 1
            thr.shadowOpacity = 2
            thr.borderWidth = 3
            
        }
        else{
            thr_trigger = false
            thr.backgroundColor = UIColor.white
            thr.borderWidth = 1
            thr.borderColor = UIColor.red
            thr.shadowRadius = 0
            thr.shadowOpacity = 0
        }
    }
    
    @IBAction func button_fri(_ sender: Any) {
        if (fri_trigger == false){
            fri_trigger = true
            fri.backgroundColor = myColor.light_yellow
            fri.borderColor = myColor.orange
            fri.shadowRadius = 1
            fri.shadowOpacity = 2
            fri.borderWidth = 3
        }
        else{
            fri_trigger = false
            fri.backgroundColor = UIColor.white
            fri.borderWidth = 1
            fri.borderColor = UIColor.red
            fri.shadowRadius = 0
            fri.shadowOpacity = 0
        }
    }
    @IBAction func button_sat(_ sender: Any) {
        if (sat_trigger == false){
            sat_trigger = true
            sat.backgroundColor = myColor.light_yellow
            sat.borderColor = myColor.orange
            sat.shadowRadius = 1
            sat.shadowOpacity = 2
            sat.borderWidth = 3
            
        }
        else{
            sat_trigger = false
            sat.backgroundColor = UIColor.white
            sat.borderWidth = 1
            sat.borderColor = UIColor.red
            sat.shadowRadius = 0
            sat.shadowOpacity = 0
        }
    }
    @IBAction func button_sun(_ sender: Any) {
        if (sun_trigger == false){
            sun_trigger = true
            sun.backgroundColor = myColor.light_yellow
            sun.borderColor = myColor.orange
            sun.shadowRadius = 1
            sun.shadowOpacity = 2
            sun.borderWidth = 3
        }
        else{
            sun_trigger = false
            sun.backgroundColor = UIColor.white
            sun.borderWidth = 1
            sun.borderColor = UIColor.red
            sun.shadowRadius = 0
            sun.shadowOpacity = 0
        }
    }
    
    
    
    
   
    

    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool{
        
        
        var check : Bool = false
        // check on the SEGUE ~~
        if identifier == "back"
        {
            check = true
        }
        
        if identifier == "segue_createRecurrency"
        {

            if(daily_trigger == false && week_trigger == false && month_trigger == false){
                check = false
                print("NO SELECTION!")
                
            }
            else{
                check = true

            }
        }
        
        return check
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "back"){
            let passingArgument = segue.destination as? NewActivity_Dates_ViewController
            
            passingArgument?.new_activity = new_activity
            passingArgument?.editing_mode_on = self.editing_mode_on
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                
            }
        }
        
        
        if(segue.identifier == "segue_createRecurrency"){
            let passingArgument = segue.destination as? NewActivity_TimeDuration_ViewController
            
            if (week_trigger != true){
                weekDaysFalse()
            }
            
            new_activity?.mon_trigger = mon_trigger
            new_activity?.tue_trigger = tue_trigger
            new_activity?.wed_trigger = wed_trigger
            new_activity?.thr_trigger = thr_trigger
            new_activity?.fri_trigger = fri_trigger
            new_activity?.sat_trigger = sat_trigger
            new_activity?.sun_trigger = sun_trigger
            
            new_activity?.daily_trigger = daily_trigger
            new_activity?.week_trigger = week_trigger
            new_activity?.month_trigger = month_trigger
            
            passingArgument?.new_activity = new_activity
            passingArgument?.editing_mode_on = self.editing_mode_on
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                
            }
        }
    }
    
    
    func updateFromOld(){
        mon_trigger = oldActivity!.monday
        tue_trigger = oldActivity!.tuesday
        wed_trigger = oldActivity!.wednseday
        thr_trigger = oldActivity!.thursday
        fri_trigger = oldActivity!.friday
        sat_trigger = oldActivity!.saturday
        sun_trigger = oldActivity!.sunday
        
        daily_trigger = oldActivity!.daily
        week_trigger = oldActivity!.weekly
        month_trigger = oldActivity!.monthly
        
        
        if daily_trigger == true{
            day.backgroundColor = myColor.light_yellow
            day.borderColor = myColor.orange
            day.shadowRadius = 1
            day.shadowOpacity = 2
            day.borderWidth = 3
            weekDisable()
        }
        if week_trigger == true{
            if mon_trigger == true {
                mon.backgroundColor = myColor.light_yellow
                mon.borderColor = myColor.orange
                mon.shadowRadius = 1
                mon.shadowOpacity = 2
                mon.borderWidth = 3
            }
            if tue_trigger == true {
                tue.backgroundColor = myColor.light_yellow
                tue.borderColor = myColor.orange
                tue.shadowRadius = 1
                tue.shadowOpacity = 2
                tue.borderWidth = 3
            }
            if wed_trigger == true {
                wed.backgroundColor = myColor.light_yellow
                wed.borderColor = myColor.orange
                wed.shadowRadius = 1
                wed.shadowOpacity = 2
                wed.borderWidth = 3
            }
            if thr_trigger == true {
                thr.backgroundColor = myColor.light_yellow
                thr.borderColor = myColor.orange
                thr.shadowRadius = 1
                thr.shadowOpacity = 2
                thr.borderWidth = 3
            }
            if fri_trigger == true {
                fri.backgroundColor = myColor.light_yellow
                fri.borderColor = myColor.orange
                fri.shadowRadius = 1
                fri.shadowOpacity = 2
                fri.borderWidth = 3
            }
            if sat_trigger == true {
                sat.backgroundColor = myColor.light_yellow
                sat.borderColor = myColor.orange
                sat.shadowRadius = 1
                sat.shadowOpacity = 2
                sat.borderWidth = 3
            }
            if sun_trigger == true {
                sun.backgroundColor = myColor.light_yellow
                sun.borderColor = myColor.orange
                sun.shadowRadius = 1
                sun.shadowOpacity = 2
                sun.borderWidth = 3
            }
            week.backgroundColor = myColor.light_yellow
            week.borderColor = myColor.orange
            week.shadowRadius = 1
            week.shadowOpacity = 2
            week.borderWidth = 3
        }
        if month_trigger == true{
            month.backgroundColor = myColor.light_yellow
            month.borderColor = myColor.orange
            month.shadowRadius = 1
            month.shadowOpacity = 2
            month.borderWidth = 3
            weekDisable()
        }
    }
    

}

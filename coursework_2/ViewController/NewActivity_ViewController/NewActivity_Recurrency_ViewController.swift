//
//  NewActivity_Recurrency_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class NewActivity_Recurrency_ViewController: UIViewController {

    
    var new_activity : Activity_obj?
    
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
    @IBOutlet weak var month: UIButton!
    @IBOutlet weak var week: UIButton!
    @IBOutlet weak var day: UIButton!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var thr: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var sun: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekDisable()
        
        if (self.editing_mode_on){
            
            updateFromOld()
        }
        // Do any additional setup after loading the view.
    }

    
    //func
    @IBAction func button_month(_ sender: Any) {
        
            month_trigger = true
            month.backgroundColor = UIColor.red
            
        
//        else{
//            mon_trigger = false
//            month.backgroundColor = UIColor.white
//
//        }
        
        setFalseByMonth()
        weekDisable()
        
    }
    @IBAction func button_week(_ sender: Any) {
        
            week_trigger = true
            week.backgroundColor = UIColor.red
            
        
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
            day.backgroundColor = UIColor.red
            
        
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
        month.backgroundColor = UIColor.white
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
        month.backgroundColor = UIColor.white
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
        week.backgroundColor = UIColor.white
    }
    
    func weekDisable(){
        mon.isEnabled = false
        tue.isEnabled = false
        wed.isEnabled = false
        thr.isEnabled = false
        fri.isEnabled = false
        sat.isEnabled = false
        sun.isEnabled = false
        
        
        mon.backgroundColor = UIColor.white
        tue.backgroundColor = UIColor.white
        wed.backgroundColor = UIColor.white
        thr.backgroundColor = UIColor.white
        fri.backgroundColor = UIColor.white
        sat.backgroundColor = UIColor.white
        sun.backgroundColor = UIColor.white


    }
    func weekEnable(){
        mon.isEnabled = true
        tue.isEnabled = true
        wed.isEnabled = true
        thr.isEnabled = true
        fri.isEnabled = true
        sat.isEnabled = true
        sun.isEnabled = true
        
        
        if mon_trigger == true {
            mon.backgroundColor = UIColor.red
        }
        if tue_trigger == true {
            tue.backgroundColor = UIColor.red
        }
        if wed_trigger == true {
            wed.backgroundColor = UIColor.red
        }
        if thr_trigger == true {
            thr.backgroundColor = UIColor.red
        }
        if fri_trigger == true {
            fri.backgroundColor = UIColor.red
        }
        if sat_trigger == true {
            sat.backgroundColor = UIColor.red
        }
        if sun_trigger == true {
            sun.backgroundColor = UIColor.red
        }
        

    }
    
    @IBAction func button_mon(_ sender: Any) {
        if (mon_trigger == false){
            mon_trigger = true
            mon.backgroundColor = UIColor.red
            
        }
        else{
           mon_trigger = false
           mon.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func button_tue(_ sender: Any) {
        if (tue_trigger == false){
            tue_trigger = true
            tue.backgroundColor = UIColor.red
            
        }
        else{
            tue_trigger = false
            tue.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func button_wed(_ sender: Any) {
        if (wed_trigger == false){
            wed_trigger = true
            wed.backgroundColor = UIColor.red
            
        }
        else{
            wed_trigger = false
            wed.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func button_thr(_ sender: Any) {
        if (thr_trigger == false){
            thr_trigger = true
            thr.backgroundColor = UIColor.red
            
        }
        else{
            thr_trigger = false
            thr.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func button_fri(_ sender: Any) {
        if (fri_trigger == false){
            fri_trigger = true
            fri.backgroundColor = UIColor.red
            
        }
        else{
            fri_trigger = false
            fri.backgroundColor = UIColor.white
        }
    }
    @IBAction func button_sat(_ sender: Any) {
        if (sat_trigger == false){
            sat_trigger = true
            sat.backgroundColor = UIColor.red
            
        }
        else{
            sat_trigger = false
            sat.backgroundColor = UIColor.white
        }
    }
    @IBAction func button_sun(_ sender: Any) {
        if (sun_trigger == false){
            sun_trigger = true
            sun.backgroundColor = UIColor.red
            
        }
        else{
            sun_trigger = false
            sun.backgroundColor = UIColor.white
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
            
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                passingArgument?.editing_mode_on = true
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
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                passingArgument?.editing_mode_on = true
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
            day.backgroundColor = UIColor.red
            weekDisable()
        }
        if week_trigger == true{
            if mon_trigger == true {
                mon.backgroundColor = UIColor.red
            }
            if tue_trigger == true {
                tue.backgroundColor = UIColor.red
            }
            if wed_trigger == true {
                wed.backgroundColor = UIColor.red
            }
            if thr_trigger == true {
                thr.backgroundColor = UIColor.red
            }
            if fri_trigger == true {
                fri.backgroundColor = UIColor.red
            }
            if sat_trigger == true {
                sat.backgroundColor = UIColor.red
            }
            if sun_trigger == true {
                sun.backgroundColor = UIColor.red
            }
            week.backgroundColor = UIColor.red
        }
        if month_trigger == true{
            month.backgroundColor = UIColor.red
            weekDisable()
        }
    }
    

}

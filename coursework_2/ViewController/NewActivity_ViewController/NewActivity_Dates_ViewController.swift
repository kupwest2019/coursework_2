//
//  NewActivity_Dates_ViewController.swift
//  coursework_2
//
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class NewActivity_Dates_ViewController: UIViewController {

    
    var new_activity : Activity_obj?
    let date_helper : DealWithDate = DealWithDate()
    var oldActivity : Activity?
    var editing_mode_on: Bool = false
    var today_plus1_ : Date?
    
    // hide the date --> infninite activity
    @IBOutlet weak var switch_EndDay: UISwitch!
    @IBAction func switch_changed(_ sender: Any) {
        
        print(switch_EndDay.isOn)
        
        if switch_EndDay.isOn == false {
            picker_EndDate.isHidden = true
            let infinite : Date = date_helper.returnInfiniteDate()
            picker_startDate.maximumDate = infinite
        }
        if (switch_EndDay.isOn == true){
            picker_EndDate.isHidden = false
            picker_startDate.maximumDate = today_plus1_

        }
    }
    
    @IBOutlet weak var picker_startDate: UIDatePicker!

    @IBOutlet weak var picker_EndDate: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // -- EDITING NAV_BAR --//
        let nav = self.navigationController?.navigationBar
        // 2
        let myColor = MyCustomColors()
        // nav?.barStyle = UIBarStyle.blackOpaque
        nav?.backgroundColor = myColor.orange
        nav?.tintColor = myColor.blue
        let nav_bar : NavigationBarCustom = ChangeTextNavigationBarAttribute()
        self.navigationItem.titleView = nav_bar.textNavBarAttributes(color1: myColor.blue, text1: "ACTIVITIES", color2: UIColor.black, text2: "new")
        
        picker_initialization()
        // Do any additional setup after loading the view.
        if self.editing_mode_on == true{
            self.picker_startDate.date = (self.oldActivity?.start_date!)!
            self.picker_EndDate.date = (self.oldActivity?.end_date)!
            self.switch_EndDay.isOn = self.oldActivity!.not_infinite
            
            if switch_EndDay.isOn == false {
                picker_EndDate.isHidden = true
            }
        }
    }
    

    
    func picker_initialization(){
        let today = Date()
        let today_plus1 = Calendar.current.date(byAdding: .day, value: +1, to: today)
        picker_EndDate.date = today_plus1!

        picker_startDate.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        picker_EndDate.addTarget(self, action: #selector(datePickerStartValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let today = sender.date
        let today_plus1 = Calendar.current.date(byAdding: .day, value: +1, to: today)
        picker_EndDate.minimumDate = today_plus1
    }
    
    
    @objc func datePickerStartValueChanged(_ sender: UIDatePicker) {
        let today = sender.date
        let today_plus1 = Calendar.current.date(byAdding: .day, value: -1, to: today)
        picker_startDate.maximumDate = today_plus1
        today_plus1_ = today_plus1
        
        
        print(today)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "back"){
             let passingArgument = segue.destination as? NewActivity_Category_ViewController
            
            passingArgument?.new_activity = new_activity
            passingArgument?.editing_mode_on = self.editing_mode_on
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                
            }
        }
        
        
        
        if(segue.identifier == "segue_createPeriod"){
            let passingArgument = segue.destination as? NewActivity_Recurrency_ViewController
            
            new_activity?.not_infinite = switch_EndDay.isOn
            
            new_activity?.start_date = date_helper.returnOnlyDayMonthYear(inputDate: picker_startDate.date)
            new_activity?.end_date = date_helper.returnOnlyDayMonthYear(inputDate: picker_EndDate.date)
            
//
//            new_activity?.start_date = picker_startDate.date
//            new_activity?.end_date = picker_EndDate.date
            
            // if the user selects infinite --> 2099/12/31 /// <---------------
            if switch_EndDay.isOn == false {
                picker_EndDate.isHidden = true
                let infinite : Date = date_helper.returnInfiniteDate()
                new_activity?.end_date = infinite
            }
            
            passingArgument?.new_activity = new_activity
            passingArgument?.editing_mode_on = self.editing_mode_on
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                
            }

        }
    }
    
    

}

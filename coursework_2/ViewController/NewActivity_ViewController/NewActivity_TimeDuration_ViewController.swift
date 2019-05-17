//
//  NewActivity_TimeDuration_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class NewActivity_TimeDuration_ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var new_activity : Activity_obj?
    
    var oldActivity : Activity?
    var editing_mode_on: Bool = false
    
    
    var time_selected = Date()
    
    @IBOutlet weak var picker_duration: UIPickerView!
    
    @IBOutlet weak var picker_timeZone: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView == picker_duration {
            return 1
            
        }
        if pickerView == picker_timeZone{
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker_duration {
            return minutes.count

        }
        if pickerView == picker_timeZone{
            return timeZones.count
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker_duration {
             return minutes[row]
            
        }
        if pickerView == picker_timeZone{
            return timeZones[row]
        }
        return ""
       
    }
    

    @IBOutlet weak var duration: UIPickerView!
    
    @IBOutlet weak var switchTime: UISwitch!

    @IBAction func togleTime(_ sender: Any) {
        print(switchTime.isOn)
        
        if switchTime.isOn == false {
            picker_timeZone.isHidden = true
        }
        if (switchTime.isOn == true){
            picker_timeZone.isHidden = false
            
        }
    }
    @IBOutlet weak var switchDuration: UISwitch!
    @IBAction func tougleDuration(_ sender: Any) {
        print(switchDuration.isOn)
        
        if switchDuration.isOn == false {
            picker_duration.isHidden = true
        }
        if (switchDuration.isOn == true){
            picker_duration.isHidden = false
            
        }
    }
    
    var minutes : [String] = []
    var minutesInt : [Int] = []
    let maximum_minutes = 60
    
    var timeZones : [String] = ["Morning", "Lunch", "Afternoon", "Night"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateMinutes()
        picker_duration.delegate = self
        picker_duration.dataSource = self
        picker_timeZone.delegate = self
        picker_timeZone.dataSource = self
        
        
        if self.editing_mode_on == true{
            
            let number : Int32 = oldActivity!.duration
            let n = Int(number)
            let index = minutesInt.firstIndex(of: n)
            
            let indexTimeZone = timeZones.firstIndex(of: oldActivity!.time!)
            
            self.picker_duration.selectRow(index!, inComponent: 0, animated: true)
            self.picker_timeZone.selectRow(indexTimeZone!, inComponent: 0, animated: true)
            
            switchDuration.isOn = oldActivity!.duration_choice
            switchTime.isOn = oldActivity!.time_choice
            
            
            if switchDuration.isOn == false {
                picker_duration.isHidden = true
            }
            if switchTime.isOn == false {
                picker_timeZone.isHidden = true
            }
   
        }

        // Do any additional setup after loading the view.
    }
    
    func populateMinutes(){
        var index : Int = 1
        while index<maximum_minutes {
            let min = "\(index) min"
            minutes.append(min)
            minutesInt.append(index)
            index = index+1
        }
    }
    
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "back"){
            let passingArgument = segue.destination as? NewActivity_Recurrency_ViewController
            
            passingArgument?.new_activity = new_activity
            
            passingArgument?.editing_mode_on = self.editing_mode_on
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                
            }
        }
        
        
        
        if(segue.identifier == "segue_createTime"){
            let passingArgument = segue.destination as? NewActivity_Partner_ViewController
            let choosenTime = minutesInt[picker_duration.selectedRow(inComponent: 0)]
            
            new_activity?.duration = choosenTime
            
            let choosenTimeZone = timeZones[picker_timeZone.selectedRow(inComponent: 0)]

            new_activity?.time = choosenTimeZone
            
            new_activity?.time_choice = switchTime.isOn
            new_activity?.duration_choice = switchDuration.isOn
            
            passingArgument?.new_activity = new_activity
            passingArgument?.editing_mode_on = self.editing_mode_on
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                
            }
        }
    }
    

}

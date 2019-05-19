//
//  NewCategory_Goal_ViewController.swift
//  coursework_2
//
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class NewCategory_Goal_ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var new_category: Category_obj = Category_obj()
    var new_activity : Activity_obj?
    var oldActivity : Activity?
    var editing_mode_on: Bool = false
    let date_helper : DealWithDate = DealWithDate()

    @IBOutlet weak var btn_create: UIButton!
    
    
    let number = ["0","5","6","7","8","9","10","15"]

    @IBOutlet weak var picker_goal: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker_goal.delegate = self
        picker_goal.dataSource = self
        print(new_category)
        if (editing_mode_on == true){
            self.btn_create.setTitle("UPDATE", for: .normal)
        }
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "back"){
            let passingArgument = segue.destination as? NewCategory_Color_ViewController
                        
            passingArgument?.new_category = new_category
            passingArgument?.new_activity = new_activity
        }
        
        
        if(segue.identifier == "segue_categoryCreated"){
            let core_data : Core_Data_Interface = accessingCoreData()
            guard let choosenGoal = Int32(number[picker_goal.selectedRow(inComponent: 0)]) as NSNumber? else {fatalError("Unexpected class type in allObjects")}
//
            core_data.createCategory(choosenGoal: choosenGoal, new_category: new_category)
            


            // passing arguments
            let passingArgument = segue.destination as? NewActivity_Category_ViewController
            passingArgument?.new_activity = new_activity
            passingArgument?.editing_mode_on = self.editing_mode_on
            if(passingArgument?.editing_mode_on == self.editing_mode_on){
                passingArgument?.oldActivity = self.oldActivity
            }
        }
        
    }
    
    
   
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return number.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return number[row]
    }
    
    
  
    
    
    
    
    
    
   
    
}

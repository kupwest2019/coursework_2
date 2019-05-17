//
//  NewCategory_Goal_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class NewCategory_Goal_ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var new_category: Category_obj = Category_obj()
    var new_activity : Activity_obj?
    var oldActivity : Activity?
    var editing_mode_on: Bool = false
    
    
    
    
    
    let number = ["5","6","7","8","9","10","15"]

    @IBOutlet weak var picker_goal: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker_goal.delegate = self
        picker_goal.dataSource = self
        print(new_category)
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "back"){
            let passingArgument = segue.destination as? NewCategory_Color_ViewController
                        
            passingArgument?.new_category = new_category
            passingArgument?.new_activity = new_activity
        }
        
        
        if(segue.identifier == "segue_categoryCreated"){
            
            // saving in Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            // create a new entity
            let entity = NSEntityDescription.entity(forEntityName: "Category", in: context)
            let newElement = NSManagedObject(entity: entity!, insertInto: context)
            
            
            let choosenGoal : NSNumber = Int32(number[picker_goal.selectedRow(inComponent: 0)])! as NSNumber
            
            
            
            newElement.setValue(new_category.color, forKey: "colour")
            newElement.setValue(choosenGoal, forKey: "goal")
            newElement.setValue(new_category.name, forKey: "name")


            // saving a entity
            do {
                try context.save()
            }catch {print("failed save!")}
            
            
            
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

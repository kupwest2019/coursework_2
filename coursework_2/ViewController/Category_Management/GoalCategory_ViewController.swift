//
//  GoalCategory_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class GoalCategory_ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    

    @IBOutlet weak var buttoncreate: UIButton!
    @IBOutlet weak var picker_goal: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker_goal.delegate = self
        picker_goal.dataSource = self
        print(new_category)
        
        
        if editingRequest{
            let numb : Int32 = self.edit_category!.goal
            let n = String(numb)
            let index = number.firstIndex(of: n)
            
            self.picker_goal.selectRow(index!, inComponent: 0, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    var new_category: Category_obj = Category_obj()
    let number = ["5","6","7","8","9","10","15"]
    var edit_category:Category?
    var editingRequest: Bool = false
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // manage the go back request
        if(segue.identifier == "back"){
            
            let passingArgument = segue.destination as? ColorCategory_ViewController
            passingArgument?.new_category = new_category
            passingArgument?.editingRequest = self.editingRequest
            
            if(editingRequest){
                passingArgument?.edit_category = self.edit_category!
            }
        }
        
        
        if(segue.identifier == "segue_categoryCreated"){
            
            // saving in Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let choosenGoal : NSNumber = Int32(number[picker_goal.selectedRow(inComponent: 0)])! as NSNumber
            
            
            // manage Update
            if(self.editingRequest){
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
                // filtering
                //request.predicate = NSPredicate(format: "age = %@", "12")
                let filter = NSPredicate(format: "name == %@", self.edit_category!.name!)
                request.predicate = filter
                
                // doing the request -- fetching the request
                request.returnsObjectsAsFaults = false
                do {
                    let result = try context.fetch(request)
                    let resultdata = result as! [Category]
                    
                    for i in resultdata{
                        i.setValue(new_category.color, forKey: "colour")
                        i.setValue(choosenGoal, forKey: "goal")
                    }
                    try context.save()
                    
                } catch {
                    print("Failed")
                }
            }
                // Manage Insert in coreData
            else{
                // create a new entity
                let entity = NSEntityDescription.entity(forEntityName: "Category", in: context)
                let newElement = NSManagedObject(entity: entity!, insertInto: context)
                
                
                
                
                newElement.setValue(new_category.name, forKey: "name")
                newElement.setValue(new_category.color, forKey: "colour")
                newElement.setValue(choosenGoal, forKey: "goal")
                
                
                // saving a entity
                do {
                    try context.save()
                }catch {print("failed save!")}
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

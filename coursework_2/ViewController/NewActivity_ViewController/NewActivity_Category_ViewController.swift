//
//  NewActivity_Category_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class NewActivity_Category_ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var new_activity : Activity_obj?
    var oldActivity : Activity?
    var editing_mode_on: Bool = false
    var selectedRowPicker : Bool = false
    
    // MARK --
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // MARK --
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return categories.count
        print(item.count)
        return item.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return categories[row]
        let item = self.item[row]
        return item.name
    }
    

    @IBOutlet weak var picker_category: UIPickerView!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    var categories : [String] = []
    var item : [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
        
        // Do any additional setup after loading the view.
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected")
        if selectedRowPicker == false {
            selectedRowPicker = true
        }
    }
    
    // to refresh in case of add new category
    override func viewWillAppear(_ animated: Bool) {
        //populateCategories()
        
        
        
        populateCategories2()
        if (item.count == 0){
            self.nextButton.isEnabled = false
        }
        picker_category.delegate = self
        picker_category.dataSource = self
        
        
        if(editing_mode_on==true){
            print("editing mood")
            let old_element_index = (populate_categories_return_index())
            picker_category.selectRow(old_element_index, inComponent: 0, animated: true)
            
        }
    }
    
    func populate_categories_return_index() -> Int  {
        for i in item{
            categories.append(i.name!)
        }
        
        return categories.firstIndex(of: (oldActivity?.cateogry?.name!)!)!
    }
    
    func populateCategories2(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(fetchRequest2) as! [Category]
            for data in result {
                item.append(data)
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        
       
    }
    

//
//    func populateCategories(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
//        // filtering
//        //request.predicate = NSPredicate(format: "age = %@", "12")
////        let filter = NSPredicate(format: "name == %@", textFiled_activityName.text!)
////        request.predicate = filter
//
//        // doing the request -- fetching the request
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//
//            for items in result{
//                let item : Category = items as! Category
//                categories.append(item.name ?? "")
//            }
//
//            print (result)
//        } catch {
//            print("Failed")
//        }
//    }
    
    
    // check if at least 1 category can be selected ...
   
    
    
    // segue policy
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      
        
        if(segue.identifier == "segue_createCategory"){
            
            if (editing_mode_on){
                
                var new_activity_2 : Activity_obj = Activity_obj(name: nil, category: nil, start_date: nil, not_infinite: false, end_date: nil, duration: nil, time: nil, time_choice: false, duration_choice: false, mon_trigger: false, tue_trigger: false, wed_trigger: false, thr_trigger: false, fri_trigger: false, sat_trigger: false, sun_trigger: false, daily_trigger: false, week_trigger: false, month_trigger: false)
                
                new_activity_2.name = oldActivity?.name
                let choosenCategory = item[picker_category.selectedRow(inComponent: 0)]
                new_activity_2.category = choosenCategory.name
                let passingArgument = segue.destination as? NewActivity_Dates_ViewController
                passingArgument?.new_activity = new_activity_2
                
                passingArgument?.oldActivity = oldActivity
                passingArgument?.editing_mode_on = true
            }
            
            else{
                
                print(picker_category.selectedRow(inComponent: 0))
                
                let choosenCategory = item[picker_category.selectedRow(inComponent: 0)]
                new_activity?.category = choosenCategory.name
                let passingArgument = segue.destination as? NewActivity_Dates_ViewController
                passingArgument?.new_activity = new_activity
            }
     
            
        }
        
        
        if(segue.identifier == "segue_createCategory_newCategory"){
            print("SEGUE NEW ACTIVITY")
            let passingArgument = segue.destination as? NewCategory_Name_ViewController
            passingArgument?.new_activity = new_activity
        }
        
        
    }
    
}

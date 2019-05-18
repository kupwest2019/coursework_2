//
//  ShowGoalCategory_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 17/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData
class ShowGoalCategory_ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var button_restart: UIButton!
    @IBOutlet weak var button_update: UIButton!
    var edit_category: Category?
    let date_helper : DealWithDate = DealWithDate()

    @IBAction func button_update(_ sender: UIButton) {
        updateGoal(date_reset: false)
        
    }
    @IBAction func button_restart(_ sender: UIButton) {
        updateGoal(date_reset: true)

    }
    
    
    func updateGoal(date_reset : Bool){
        
        guard let choosenGoal : NSNumber = Int32(number[goal_picker.selectedRow(inComponent: 0)]) as NSNumber? else {fatalError("Conversion Not Possible")}
        
        
        guard let category : Category = self.edit_category else {fatalError("Conversion Not Possible")}
        guard let category_name : String = category.name else {fatalError("Conversion Not Possible")}
        

        
        let core_data : Core_Data_Interface = accessingCoreData()
        core_data.updateGoal(date_reset: date_reset, activity_name: category_name, newGoal: choosenGoal)
        
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let choosenGoal : NSNumber = Int32(number[goal_picker.selectedRow(inComponent: 0)])! as NSNumber
//        let today : Date = Date()
//        let newDate = date_helper.returnOnlyDayMonthYear(inputDate: today)
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
//        // filtering
//        //request.predicate = NSPredicate(format: "age = %@", "12")
//        let filter = NSPredicate(format: "name == %@", self.edit_category!.name!)
//        request.predicate = filter
//
//        // doing the request -- fetching the request
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//            let resultdata = result as! [Category]
//
//            for i in resultdata{
//                i.setValue(choosenGoal, forKey: "goal")
//                if(date_reset == true){
//                    i.setValue(newDate, forKey: "startDate")
//                }
//                //
//            }
//            try context.save()
//
//        } catch {
//            print("Failed")
//        }
    }
    
    
    
    let number = ["0","5","6","7","8","9","10","15"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return number.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return number[row]
    }
    
    
    @IBOutlet weak var goal_picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goal_picker.delegate = self
        goal_picker.dataSource = self
        
        guard let category : Category = self.edit_category else {fatalError("Conversion Not Possible")}
        
        let numb : Int32 = category.goal
        let n = String(numb)
        let index = number.firstIndex(of: n)
        
        self.goal_picker.selectRow(index!, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
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

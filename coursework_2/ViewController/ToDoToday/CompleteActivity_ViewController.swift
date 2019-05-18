//
//  CompleteActivity_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 16/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class CompleteActivity_ViewController: UIViewController {

    @IBOutlet weak var label_recurrency: UILabel!
    
    @IBOutlet weak var activity_date: UILabel!
    @IBOutlet weak var button_complete: RoundButtonDesignable!
    
    @IBOutlet weak var start_button: UIButton!
    @IBOutlet weak var label_partner: UILabel!
    
    @IBOutlet weak var label_timer: UILabel!
    var activityToBeExecuted : Activity?
    var dateOfActivity:Date?
    
    
    @IBAction func complete_button(_ sender: Any) {
        let alertController = UIAlertController(title: "Warning", message: "🐵 Have you really completed the activity? 🐵", preferredStyle: .alert)
        
        let complete = UIAlertAction(title: "Yes Sure!", style: .destructive, handler: { (action) in
            self.insertActivityInCoreDataCompleted()
            self.navigationController?.popViewController(animated: true)

        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(complete)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func insertActivityInCoreDataCompleted(){
        print("completed Actvity")
        updateCoreData()
        self.button_complete.isEnabled = false
        
    }
    
    
    func updateCoreData(){
        
        let core_data : Core_Data_Interface = accessingCoreData()
        guard let activity_exec = activityToBeExecuted else {fatalError("Unexpected class type in allObjects")}
        guard let date_activity = self.dateOfActivity else {fatalError("Unexpected class type in allObjects")}
        
        core_data.completeAnActivity(activityToBeExecuted: activity_exec, dateOfActivity: date_activity)
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        // manage Update
//        // create a new entity
//        let entity = NSEntityDescription.entity(forEntityName: "CompletedActivity", in: context)
//        let newElement = NSManagedObject(entity: entity!, insertInto: context)
//        newElement.setValue(self.activityToBeExecuted!.name, forKey: "activity_name")
//        newElement.setValue(self.dateOfActivity!, forKey: "date")
//        newElement.setValue(self.activityToBeExecuted?.cateogry?.name!, forKey: "category")
//
//        // saving a entity
//        do {
//            try context.save()
//        }catch {print("failed save!")}
//
        
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let date_helper : DealWithDate = DealWithDate()
        let day_description = date_helper.returnCalendarDayMonthYear(inputDate: dateOfActivity!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: dateOfActivity!)
        
        self.activity_date.text = "\(dayInWeek) : \(day_description.day ?? 0) - \(day_description.month ?? 0) "
        
        print(activityToBeExecuted)
        
        
        
        if(activityToBeExecuted?.duration_choice == false){
            start_button.isEnabled = false
            label_timer.text = "not set"
        }
        else{
            let duration = activityToBeExecuted!.duration
            print(activityToBeExecuted?.duration)
            let duration_string : String = String(duration)
            label_timer.text = "\(duration_string) minutes"
        }
        
        
        
        
        if (activityToBeExecuted!.monthly){
            label_recurrency.text = "Monthly"
            
        }
        if(activityToBeExecuted!.daily){
            label_recurrency.text = "Daily"
            
        }
        if(activityToBeExecuted!.weekly){
            label_recurrency.text = "Weekly"
        }
        
        label_partner.text = "Not Provided YET"
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "next"){
            let passingArgument = segue.destination as? Timer_ViewController
            passingArgument?.activityToBeExecuted = self.activityToBeExecuted
            passingArgument?.dateOfActivity = self.dateOfActivity
        }
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

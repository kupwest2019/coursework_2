//
//  NewActivity_Partner_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import Contacts
import CoreData

class NewActivity_Partner_ViewController: UIViewController {

    @IBAction func edit(_ sender: Any) {
    }
    
    var new_activity : Activity_obj?
    var oldActivity : Activity?
    var editing_mode_on: Bool = false
    let core_data : Core_Data_Interface = accessingCoreData()

    @IBAction func save_new_activity(_ sender: Any) {
        
        let result = test_modification()
        
        
        if (editing_mode_on == true){
             if (result){
                print("ITEM UPDATED!!!!")
                
                guard let new_act : Activity_obj = new_activity else {fatalError("Unexpected class type in allObjects")}
                
                
                guard let old_act : Activity = oldActivity else {fatalError("Unexpected class type in allObjects")}

                
                core_data.updateActivity(new_activity: new_act, oldActivity: old_act)
                //writing_on_CoreDataUpdate()
                
            }
             else{
                print("NO MODIFICATION !!!")
            }
        }
        if (editing_mode_on == false){
            guard let new_act : Activity_obj = new_activity else {fatalError("Unexpected class type in allObjects")}
            
            core_data.createNewActivity(new_activity: new_act)
            
            //writing_on_CoreData()
        }
        
        
    }
    
    func deleting_previous_activity(){
        print("YOO DELETING")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
        let filter = NSPredicate(format: "name == %@", self.oldActivity!.name!)
        request.predicate = filter
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
            print("YO - RESULT")
            let result = try context.fetch(request)
            if (result.count > 0){
                let manage = result[0] as! NSManagedObject
                context.delete(manage)
                // saving a entity
                do {
                    try context.save()
                }catch {print("failed save!")}
            }
            
            //            for data in result as! [NSManagedObject] {
            //                print(data.value(forKey: "name") as! String)
            //            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    
    // manage Update CoreData
    func writing_on_CoreDataUpdate(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // create a new entity
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
        let filter = NSPredicate(format: "name == %@", self.oldActivity!.name!)
        request.predicate = filter
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let resultdata = result as! [Activity]
            
            for newElement in resultdata{
                newElement.setValue(new_activity?.start_date, forKey: "start_date")
                newElement.setValue(new_activity?.not_infinite, forKey: "not_infinite")
                newElement.setValue(new_activity?.end_date, forKey: "end_date")
                newElement.setValue(new_activity?.duration, forKey: "duration")
                newElement.setValue(new_activity?.time, forKey: "time")
                newElement.setValue(new_activity?.mon_trigger, forKey: "monday")
                newElement.setValue(new_activity?.tue_trigger, forKey: "tuesday")
                newElement.setValue(new_activity?.wed_trigger, forKey: "wednseday")
                newElement.setValue(new_activity?.thr_trigger, forKey: "thursday")
                newElement.setValue(new_activity?.fri_trigger, forKey: "friday")
                newElement.setValue(new_activity?.sat_trigger, forKey: "saturday")
                newElement.setValue(new_activity?.sun_trigger, forKey: "sunday")
                newElement.setValue(new_activity?.month_trigger, forKey: "monthly")
                newElement.setValue(new_activity?.week_trigger, forKey: "weekly")
                newElement.setValue(new_activity?.daily_trigger, forKey: "daily")
                newElement.setValue(new_activity?.time_choice, forKey: "time_choice")
                newElement.setValue(new_activity?.duration_choice, forKey: "duration_choice")
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
                
                // filtering
                //request.predicate = NSPredicate(format: "age = %@", "12")
                
                
                // add to New Category

                if let category = new_activity?.category{
                    let filter = NSPredicate(format: "name == %@", category)
                    request.predicate = filter
                    
                    // doing the request -- fetching the request
                    request.returnsObjectsAsFaults = false
                    do {
                        let result = try context.fetch(request)
                        for data in result as! [Category] {
                            
                            
                            //                    var category = Category(context: context)
                            //                    category = data
                            data.addToActivities(newElement)
                            
                            print(category)
                        }
                        
                    } catch {
                        
                        print("Failed")
                    }
                }
                
                // remove from previous Category
                if let category = oldActivity!.cateogry{
                    let filter = NSPredicate(format: "name == %@", category)
                    request.predicate = filter
                    
                    // doing the request -- fetching the request
                    request.returnsObjectsAsFaults = false
                    do {
                        let result = try context.fetch(request)
                        for data in result as! [Category] {
                            
                            
                            //                    var category = Category(context: context)
                            //                    category = data
                            data.removeFromActivities(newElement)
                            
                            print(category)
                        }
                        
                    } catch {
                        
                        print("Failed")
                    }
                }
                try context.save()
            }
  
        } catch {
            print("Failed")
        }
    }
    
    
    func writing_on_CoreData(){
        
        
        
        
        // instantiation
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//
//
//
//
//        // create a new entity
//        let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
//        let newElement = NSManagedObject(entity: entity!, insertInto: context)
//        newElement.setValue(new_activity?.name, forKey: "name")
//        //newElement.setValue(new_activity?.category, forKey: "category")
//        newElement.setValue(new_activity?.start_date, forKey: "start_date")
//        newElement.setValue(new_activity?.not_infinite, forKey: "not_infinite")
//        newElement.setValue(new_activity?.end_date, forKey: "end_date")
//        newElement.setValue(new_activity?.duration, forKey: "duration")
//        newElement.setValue(new_activity?.time, forKey: "time")
//        newElement.setValue(new_activity?.mon_trigger, forKey: "monday")
//        newElement.setValue(new_activity?.tue_trigger, forKey: "tuesday")
//        newElement.setValue(new_activity?.wed_trigger, forKey: "wednseday")
//        newElement.setValue(new_activity?.thr_trigger, forKey: "thursday")
//        newElement.setValue(new_activity?.fri_trigger, forKey: "friday")
//        newElement.setValue(new_activity?.sat_trigger, forKey: "saturday")
//        newElement.setValue(new_activity?.sun_trigger, forKey: "sunday")
//        newElement.setValue(new_activity?.month_trigger, forKey: "monthly")
//        newElement.setValue(new_activity?.week_trigger, forKey: "weekly")
//        newElement.setValue(new_activity?.daily_trigger, forKey: "daily")
//        newElement.setValue(new_activity?.time_choice, forKey: "time_choice")
//        newElement.setValue(new_activity?.duration_choice, forKey: "duration_choice")
//
//        // saving a entity
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
//
//        // filtering
//        //request.predicate = NSPredicate(format: "age = %@", "12")
//
//        if let category = new_activity?.category{
//            let filter = NSPredicate(format: "name == %@", category)
//            request.predicate = filter
//
//            // doing the request -- fetching the request
//            request.returnsObjectsAsFaults = false
//            do {
//                let result = try context.fetch(request)
//                for data in result as! [Category] {
//
//
//                    //                    var category = Category(context: context)
//                    //                    category = data
//                    data.addToActivities(newElement as! Activity)
//
//                    print(category)
//                }
//
//            } catch {
//
//                print("Failed")
//            }
//
//            do {
//                try context.save()
//            }catch {print("failed save!")}
//        }
    }




    
  
    func test_modification() -> Bool {
        var nomodification : Bool = true
        var duration = 0
        if let number : Int32 = oldActivity?.duration {
            duration = Int(number)
        }
        
        print("------------")
        print(oldActivity)
        print("------------")
        print(self.new_activity)
        
        print("------------")

        
        if(self.oldActivity?.cateogry?.name == self.new_activity?.category &&
            new_activity?.start_date == oldActivity?.start_date &&
            new_activity?.not_infinite == oldActivity?.not_infinite &&
            new_activity?.end_date == oldActivity?.end_date &&
            new_activity?.duration == duration &&
            new_activity?.time == oldActivity?.time &&
            new_activity?.mon_trigger == oldActivity?.monday &&
            new_activity?.tue_trigger == oldActivity?.tuesday &&
            new_activity?.wed_trigger == oldActivity?.wednseday &&
            new_activity?.thr_trigger == oldActivity?.thursday &&
            new_activity?.fri_trigger == oldActivity?.friday &&
            new_activity?.sat_trigger == oldActivity?.saturday &&
            new_activity?.sun_trigger == oldActivity?.sunday &&
            new_activity?.month_trigger == oldActivity?.monthly &&
            new_activity?.week_trigger == oldActivity?.weekly &&
            new_activity?.daily_trigger == oldActivity?.daily &&
            new_activity?.time_choice == oldActivity?.time_choice &&
            new_activity?.duration_choice == oldActivity?.duration_choice
        )
        {
            nomodification = false
        }
        else{
            nomodification = true
        }
        
        return nomodification
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(new_activity)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "back"){
            let passingArgument = segue.destination as? NewActivity_TimeDuration_ViewController
            
            passingArgument?.new_activity = new_activity
            passingArgument?.editing_mode_on = self.editing_mode_on
            if (self.editing_mode_on){
                passingArgument?.oldActivity = oldActivity
                
            }
        }
    }
        
    

  

}

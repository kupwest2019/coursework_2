// define the protocol and the functions for accessing the Core Data of the app



import Foundation
import CoreData
import UIKit

protocol Core_Data_Interface {
    func returnAllCategry() -> [Category]
    func returnAllCompletedActivities() -> [CompletedActivity]
    func updateGoal(date_reset : Bool, activity_name: String, newGoal: NSNumber)
    func returnCompletedActivitiesTwoDates(start_date : Date, end_date: Date) -> [CompletedActivity]
    func return_To_Do_Activities_TwoDates(start_date : Date, end_date: Date) -> [Activity]
    func populateScheduledActivities(activities : [Activity], startDate : Date, endDate : Date) -> [Activity]
    func completeAnActivity(activityToBeExecuted : Activity, dateOfActivity: Date)
    func returnAllActivities() -> [Activity]
    func deleteActivity(name_activity : String)
    func createCategory(choosenGoal : NSNumber, new_category : Category_obj)
    func createNewActivity(new_activity : Activity_obj)
    func updateActivity(new_activity: Activity_obj, oldActivity: Activity)
    func deleteAll()

}


class accessingCoreData : Core_Data_Interface{
    
    let date_helper : DealWithDate = DealWithDate()

    
    func deleteAll(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        
        fetchRequest1.returnsObjectsAsFaults = false
        do {
            
            guard let result = try context.fetch(fetchRequest1) as? [Category] else {fatalError("Unexpected class type in allObjects")}
            
            for data in result {
                context.delete(data)
            }
            // guard in exctraction
            try context.save()
            
        } catch {
            print("Failed")
        }
        
        
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            
            guard let result = try context.fetch(fetchRequest2) as? [Activity] else {fatalError("Unexpected class type in allObjects")}
            
            for data in result {
                context.delete(data)
            }
            // guard in exctraction
            try context.save()
            
        } catch {
            print("Failed")
        }
        
        let fetchRequest3 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")

        fetchRequest3.returnsObjectsAsFaults = false
        do {
            
            guard let result = try context.fetch(fetchRequest3) as? [CompletedActivity] else {fatalError("Unexpected class type in allObjects")}
            
            for data in result {
                context.delete(data)
            }
            // guard in exctraction
            try context.save()
            
        } catch {
            print("Failed")
        }
        
       
    }
    
    
    func returnAllCategry() -> [Category]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")

        fetchRequest2.returnsObjectsAsFaults = false
        
        var categories : [Category] = []
        
        do {
            // guard in exctraction
            guard let result = try context.fetch(fetchRequest2) as? [Category] else {fatalError("Unexpected class type in allObjects")}
            
            for data in result {
                categories.append(data)
            }
            
        } catch {
            
            print("Failed")
        }
        
        return categories
    }
    
    
    func returnAllCompletedActivities() -> [CompletedActivity]{
        var completedActivities : [CompletedActivity] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")
        
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            
            guard let result = try context.fetch(fetchRequest2) as? [CompletedActivity] else {fatalError("Unexpected class type in allObjects")}
            
            for data in result {
                completedActivities.append(data)
            }
            
        } catch {
            
            print("Failed")
        }
        
        return completedActivities
    }
    
    func updateGoal(date_reset : Bool, activity_name: String, newGoal: NSNumber) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let today : Date = Date()
        let newDate = date_helper.returnOnlyDayMonthYear(inputDate: today)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
        let filter = NSPredicate(format: "name == %@", activity_name)
        request.predicate = filter
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let resultdata = result as! [Category]
            
            for i in resultdata{
                i.setValue(newGoal, forKey: "goal")
                if(date_reset == true){
                    i.setValue(newDate, forKey: "startDate")
                }
                //
            }
            try context.save()
            
        } catch {
            print("Failed")
        }
        
        
    }
    
    
    
    func returnCompletedActivitiesTwoDates(start_date : Date, end_date: Date) -> [CompletedActivity]{
        var completedActivities : [CompletedActivity] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")
        
        let fromPredicate = NSPredicate(format: "date >= %@", start_date as NSDate)
        let toPredicate = NSPredicate(format: "date =< %@", end_date as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        fetchRequest2.predicate = datePredicate
        
        
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            
            guard let result = try context.fetch(fetchRequest2) as? [CompletedActivity] else {fatalError("Unexpected class type in allObjects")}
            
            for data in result {
                completedActivities.append(data)
            }
            
        } catch {
            
            print("Failed")
        }
        
        return completedActivities
    }
    
    
    func return_To_Do_Activities_TwoDates(start_date : Date, end_date: Date) -> [Activity]{
        var to_do_Activities : [Activity] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        let fromPredicate = NSPredicate(format: "end_date >= %@", start_date as NSDate)
        let toPredicate = NSPredicate(format: "start_date =< %@", end_date as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        fetchRequest2.predicate = datePredicate
        
        
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            
            guard let result = try context.fetch(fetchRequest2) as? [Activity] else {fatalError("Unexpected class type in allObjects")}
            
            for data in result {
                to_do_Activities.append(data)
            }
            
        } catch {
            
            print("Failed")
        }
        
        return to_do_Activities
    }
    
    
    
    func populateScheduledActivities(activities : [Activity], startDate : Date, endDate : Date) -> [Activity]{
        
        var item : [Activity] = []
        
        for activity in activities{
            print("SEARCH")
            
            let date_helper : DealWithDate = DealWithDate()
            
            let startdate_activity = date_helper.returnOnlyDayMonthYear(inputDate: activity.start_date!)
            let enddate_activity = date_helper.returnOnlyDayMonthYear_LastDate(inputDate: activity.end_date!)
            
            
            
            
            if (activity.monthly == true){
                
                var newValue = Calendar.current.date(byAdding: .month, value: 0, to: startdate_activity)
                
                while(newValue! <= enddate_activity && newValue! <= endDate){
                    
                    
                    // check if consider the activity
                    if (newValue! >= startDate && newValue! <= endDate){
                        item.append(activity)
                    }
                    
                    newValue = Calendar.current.date(byAdding: .month, value: 1, to: newValue!)
                    
                }
                
            }
            else if (activity.daily == true){
                
                var newValue = Calendar.current.date(byAdding: .day, value: 0, to: startdate_activity)
                
                print("I AM HERE")
                
                // < end_date of activity (2099 if infinite) && end_date month
                while(newValue! <= enddate_activity){
                    
                    
                    print("Evaluation Date --> \(newValue!)")
                    print("Activity Start --> \(startDate)")
                    print("Activity End --> \(endDate)")
                    
                    // check if consider the activity
                    if (newValue! >= startDate && newValue! <= endDate){
                        
                        print("I AM APPENDING")
                        item.append(activity)
                        
                    }
                    
                    newValue = Calendar.current.date(byAdding: .day, value: 1, to: newValue!)
                    
                }
                
                
            }
            else if (activity.weekly == true){
                var newValue = Calendar.current.date(byAdding: .day, value: 0, to: startdate_activity)
                
                // < end_date of activity (2099 if infinite) && end_date month
                while(newValue! <= enddate_activity && newValue! <= endDate){
                    
                    //
                    print("Evaluation Date --> \(newValue!)")
                    print("Activity Start --> \(startdate_activity)")
                    print("Activity End --> \(enddate_activity)")
                    
                    // check if consider the activity
                    if (newValue! >= startDate && newValue! <= endDate){
                        
                        
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEEE"
                        let dayInWeek = dateFormatter.string(from: newValue!)
                        
                        if(dayInWeek == "Sunday" && activity.sunday == true){
                            item.append(activity)
                            
                        }
                        else if(dayInWeek == "Monday" && activity.monday == true){
                            item.append(activity)
                            
                        }
                        else if(dayInWeek == "Tuesday" && activity.tuesday == true){
                            item.append(activity)
                            
                        }
                        else if(dayInWeek == "Wednesday" && activity.wednseday == true){
                            item.append(activity)
                            
                        }
                        else if(dayInWeek == "Thursday" && activity.thursday == true){
                            item.append(activity)
                            
                        }
                        else if(dayInWeek == "Friday" && activity.friday == true){
                            item.append(activity)
                            
                        }
                        else if(dayInWeek == "Saturday" && activity.saturday == true){
                            item.append(activity)
                        }
                        
                        
                    }
                    newValue = Calendar.current.date(byAdding: .day, value: 1, to: newValue!)
                    
                }
                
            }
        }
        
        return item
        
        
    }
    
    
    func completeAnActivity(activityToBeExecuted : Activity, dateOfActivity: Date){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // manage Update
        // create a new entity
        let entity = NSEntityDescription.entity(forEntityName: "CompletedActivity", in: context)
        
        
        
        let newElement = NSManagedObject(entity: entity!, insertInto: context)
        newElement.setValue(activityToBeExecuted.name, forKey: "activity_name")
        newElement.setValue(dateOfActivity, forKey: "date")
        guard let category = activityToBeExecuted.cateogry else {fatalError("Unexpected class type in allObjects")}
        guard let category_name = category.name else {fatalError("Unexpected class type in allObjects")}
        newElement.setValue(category_name, forKey: "category")
        
        // saving a entity
        do {
            try context.save()
        }catch {print("failed save!")}
    }
    
    
    func returnAllActivities() -> [Activity]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        fetchRequest2.returnsObjectsAsFaults = false
        
        var activities : [Activity] = []
        
        do {
            // guard in exctraction
            guard let result = try context.fetch(fetchRequest2) as? [Activity] else {fatalError("Unexpected class type in allObjects")}
            
            for data in result {
                activities.append(data)
            }
            
        } catch {
            
            print("Failed")
        }
        
        return activities
    }
    
    
    func deleteActivity(name_activity : String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
  
        print ("TO BE DELETED --> \(name_activity)")
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        // filtering
        // DELETE ACTIVITIES
        let filter = NSPredicate(format: "name == %@", name_activity)
        request.predicate = filter
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
           //let result = try context.fetch(request)
            guard let result = try context.fetch(request) as? [Activity] else {fatalError("Unexpected class type in allObjects")}
            
         
            for activity in result{
                context.delete(activity)
            }
            do {
                try context.save()
            }catch
            {
                print("Failed")
            }
            
//            if (result.count > 0){
//                let manage = result[0]
//                context.delete(manage)
//                // saving a entity
//                do {
//                    try context.save()
//                }catch {print("failed save!")}
//            }
        } catch {
            print("Failed")
        }
        
        
        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")
        
        // filtering
        let filter2 = NSPredicate(format: "activity_name == %@", name_activity)
        request2.predicate = filter2
  
        // doing the request -- fetching the request
        request2.returnsObjectsAsFaults = false
        do {
            print("YO - RESULT")
            //let result = try context.fetch(request2)
            
            
            guard let result2 = try context.fetch(request2) as? [CompletedActivity] else {fatalError("Unexpected class type in allObjects")}
            
            
            for activity in result2{
                context.delete(activity)
            }
            do {
                try context.save()
            }catch
            {
                print("Failed")
            }
//
//
//
//
//
//
//            if (result.count > 0){
//                let manage = result[0] as! NSManagedObject
//                context.delete(manage)
//                // saving a entity
//                do {
//                    try context.save()
//                }catch {print("failed save!")}
//            }
//            else if (result.count == 0){          // delete it
//                print("YO - NO ACTIVITIES WERE COMPLETED")
//            }
        }catch {
            print("Failed")
        }
    }
    
    
    func createCategory(choosenGoal : NSNumber, new_category : Category_obj){
        
        // saving in Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // create a new entity
        let entity = NSEntityDescription.entity(forEntityName: "Category", in: context)
        let newElement = NSManagedObject(entity: entity!, insertInto: context)
        
//
//        let choosenGoal : NSNumber = Int32(number[picker_goal.selectedRow(inComponent: 0)])! as NSNumber
        
        
        let today : Date = Date()
        
        let newDate = date_helper.returnOnlyDayMonthYear(inputDate: today)
        
        newElement.setValue(new_category.color, forKey: "colour")
        newElement.setValue(choosenGoal, forKey: "goal")
        newElement.setValue(new_category.name, forKey: "name")
        newElement.setValue(newDate, forKey: "startDate")
        
        
        // saving a entity
        // saving a entity
        do {
            try context.save()
        }catch {print("failed save!")}
    }
    
    
    
    func createNewActivity(new_activity : Activity_obj){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        
        
        // create a new entity
        let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
        let newElement = NSManagedObject(entity: entity!, insertInto: context)
        newElement.setValue(new_activity.name, forKey: "name")
        //newElement.setValue(new_activity?.category, forKey: "category")
        newElement.setValue(new_activity.start_date, forKey: "start_date")
        newElement.setValue(new_activity.not_infinite, forKey: "not_infinite")
        newElement.setValue(new_activity.end_date, forKey: "end_date")
        newElement.setValue(new_activity.duration, forKey: "duration")
        newElement.setValue(new_activity.time, forKey: "time")
        newElement.setValue(new_activity.mon_trigger, forKey: "monday")
        newElement.setValue(new_activity.tue_trigger, forKey: "tuesday")
        newElement.setValue(new_activity.wed_trigger, forKey: "wednseday")
        newElement.setValue(new_activity.thr_trigger, forKey: "thursday")
        newElement.setValue(new_activity.fri_trigger, forKey: "friday")
        newElement.setValue(new_activity.sat_trigger, forKey: "saturday")
        newElement.setValue(new_activity.sun_trigger, forKey: "sunday")
        newElement.setValue(new_activity.month_trigger, forKey: "monthly")
        newElement.setValue(new_activity.week_trigger, forKey: "weekly")
        newElement.setValue(new_activity.daily_trigger, forKey: "daily")
        newElement.setValue(new_activity.time_choice, forKey: "time_choice")
        newElement.setValue(new_activity.duration_choice, forKey: "duration_choice")
        
        // saving a entity
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
        guard let category_Name : String = new_activity.category else {fatalError("Unexpected class type in allObjects")}
        
        
            let filter = NSPredicate(format: "name == %@", category_Name)
            request.predicate = filter
            
            // doing the request -- fetching the request
            request.returnsObjectsAsFaults = false
            do {
                
                guard let result = try context.fetch(request) as? [Category] else {fatalError("Unexpected class type in allObjects")}

                for data in result{
                    data.addToActivities(newElement as! Activity)
                }
                
            } catch {
                
                print("Failed")
            }
            
            do {
                try context.save()
            }catch {print("failed save!")}
        }
    
    
    
    func updateActivity(new_activity: Activity_obj, oldActivity: Activity){
        deleting_previous_activity(oldActivity: oldActivity)
        createNewActivity(new_activity: new_activity)
        updateCompletedActivity(new_activity: new_activity)
    }

    
    
    func updateActivity2(new_activity: Activity_obj, oldActivity: Activity){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // create a new entity
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
      
        
        
        guard let old_Act_Name : String = oldActivity.name else {fatalError("Unexpected class type in allObjects")}
        
        
        let filter = NSPredicate(format: "name == %@", old_Act_Name)
        request.predicate = filter
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
 
            
            
            guard let resultdata = try context.fetch(request) as? [Activity] else {fatalError("Unexpected class type in allObjects")}
            
            
            
            for newElement in resultdata{

                newElement.setValue(new_activity.start_date, forKey: "start_date")
                newElement.setValue(new_activity.not_infinite, forKey: "not_infinite")
                newElement.setValue(new_activity.end_date, forKey: "end_date")
                newElement.setValue(new_activity.duration, forKey: "duration")
                newElement.setValue(new_activity.time, forKey: "time")
                newElement.setValue(new_activity.mon_trigger, forKey: "monday")
                newElement.setValue(new_activity.tue_trigger, forKey: "tuesday")
                newElement.setValue(new_activity.wed_trigger, forKey: "wednseday")
                newElement.setValue(new_activity.thr_trigger, forKey: "thursday")
                newElement.setValue(new_activity.fri_trigger, forKey: "friday")
                newElement.setValue(new_activity.sat_trigger, forKey: "saturday")
                newElement.setValue(new_activity.sun_trigger, forKey: "sunday")
                newElement.setValue(new_activity.month_trigger, forKey: "monthly")
                newElement.setValue(new_activity.week_trigger, forKey: "weekly")
                newElement.setValue(new_activity.daily_trigger, forKey: "daily")
                newElement.setValue(new_activity.time_choice, forKey: "time_choice")
                newElement.setValue(new_activity.duration_choice, forKey: "duration_choice")
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
                
                // filtering
                //request.predicate = NSPredicate(format: "age = %@", "12")
                
                
                // add to New Category
                
                guard let new_Cat_Name : String = new_activity.name else {fatalError("Unexpected class type in allObjects")}
                
                let filter = NSPredicate(format: "name == %@", new_Cat_Name)
                request.predicate = filter
                
                // doing the request -- fetching the request
                request.returnsObjectsAsFaults = false
                do {
                    
                    guard let result = try context.fetch(request) as? [Category] else {fatalError("Unexpected class type in allObjects")}
        
                    for data in result {
                        data.addToActivities(newElement)
                    }
                    
                } catch {
                    
                    print("Failed")
                }
                do {
                    try context.save()
                }catch {print("failed save!")}
                
                
                
                
                // remove from previous Category
                guard let old_Act_category : Category = oldActivity.cateogry else {fatalError("Unexpected class type in allObjects")}
                
                guard let old_Act_category_name : String = old_Act_category.name else {fatalError("Unexpected class type in allObjects")}
                
                
                let filter_old_activity = NSPredicate(format: "name == %@", old_Act_category_name)
                request.predicate = filter_old_activity
                    
                // doing the request -- fetching the request
                request.returnsObjectsAsFaults = false
                do {
                     guard let result = try context.fetch(request) as? [Category] else {fatalError("Unexpected class type in allObjects")}
                    
                        for data in result {
                            data.removeFromActivities(newElement)
                            
                        }
                        
                    } catch {
                        
                        print("Failed")
                }
                do {
                    try context.save()
                }catch {print("failed save!")}
                
                
                
                let request3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
                
                // filtering
                //request.predicate = NSPredicate(format: "age = %@", "12")
                guard let category_Name : String = new_activity.category else {fatalError("Unexpected class type in allObjects")}
                
                
                let filter3 = NSPredicate(format: "name == %@", category_Name)
                request3.predicate = filter3
                
                // doing the request -- fetching the request
                request3.returnsObjectsAsFaults = false
                do {
                    
                    guard let result = try context.fetch(request) as? [Category] else {fatalError("Unexpected class type in allObjects")}
                    
                    for data in result{
                        data.addToActivities(newElement)
                    }
                    
                } catch {
                    
                    print("Failed")
                }
                
                do {
                    try context.save()
                }catch {print("failed save!")}
            }
            
            } catch {
                print("Failed")
            }
            
    }
    
    
    
    
    func deleting_previous_activity(oldActivity: Activity){
        
        guard let old_Act_Name : String = oldActivity.name else {fatalError("Unexpected class type in allObjects")}

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        // filtering
        // DELETE ACTIVITIES
        let filter = NSPredicate(format: "name == %@", old_Act_Name)
        request.predicate = filter
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
            //let result = try context.fetch(request)
            guard let result = try context.fetch(request) as? [Activity] else {fatalError("Unexpected class type in allObjects")}
            
            
            for activity in result{
                context.delete(activity)
            }
            do {
                try context.save()
            }catch
            {
                print("Failed")
            }
        } catch {
            print("Failed")
        }

    }
    
    
    func updateCompletedActivity(new_activity: Activity_obj){
        
        guard let new_activity_name : String = new_activity.name else {fatalError("Unexpected class type in allObjects")}

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")
        
        // filtering
        let filter2 = NSPredicate(format: "activity_name == %@", new_activity_name)
        request2.predicate = filter2
        
        // doing the request -- fetching the request
        request2.returnsObjectsAsFaults = false
        do {
            //let result = try context.fetch(request2)
            
            
            guard let category_name = new_activity.category else {fatalError("Unexpected class type in allObjects")}
            guard let result2 = try context.fetch(request2) as? [CompletedActivity] else {fatalError("Unexpected class type in allObjects")}
            
            
            for activity in result2{
                activity.setValue(category_name, forKey: "category")

            }
            do {
                try context.save()
            }catch
            {
                print("Failed")
            }
        
        }catch
        {
            print("Failed")
        }
    }
    
    
    
   
    
    
    
   
        
    
}
    



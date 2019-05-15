//
//  NewActivity_Name_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class NewActivity_Name_ViewController: UIViewController {

    @IBOutlet weak var textFiled_activityName: UITextField!
    
    
    // helper object to trasfer init
    var new_activity : Activity_obj = Activity_obj(name: nil, category: nil, start_date: nil, not_infinite: false, end_date: nil, duration: nil, time: nil, time_choice: false, duration_choice: false, mon_trigger: false, tue_trigger: false, wed_trigger: false, thr_trigger: false, fri_trigger: false, sat_trigger: false, sun_trigger: false, daily_trigger: false, week_trigger: false, month_trigger: false)
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // test if can be created
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool{
        
        // check on the SEGUE ~~
        if identifier == "segue_fromActivityNewName"
        {
            
            var check_univocity : Bool = false
            
            if let name = textFiled_activityName.text{
                
                // to avoid duplicate with the same name but different CAP
                let new_name = name.lowercased()
                
                // check if it is empty
                if (new_name.count == 0){
                    print("NEED AT LEAST 1")
                    
                }
                else{
                    // perform check if the activity is already present
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
                    // filtering
                    //request.predicate = NSPredicate(format: "age = %@", "12")
                    let filter = NSPredicate(format: "name == %@", new_name)
                    request.predicate = filter
                    
                    // doing the request -- fetching the request
                    request.returnsObjectsAsFaults = false
                    do {
                        let result = try context.fetch(request)
                        print("number of occurence present present --> ", result.count)
                        if (result.count == 0){
                            check_univocity = true
                            new_activity.name = new_name
                        }
                        else{
                            print("DUPLICATE")
                        }
                    } catch {
                        print("Failed")
                    }
                }
            }
          
            
            
            print(new_activity)
            return check_univocity

        }
        else{
            // is the back segue
            return true;

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "segue_fromActivityNewName"){
            let passingArgument = segue.destination as? NewActivity_Category_ViewController
            passingArgument?.new_activity = new_activity
        }
    }
    
    
    

}

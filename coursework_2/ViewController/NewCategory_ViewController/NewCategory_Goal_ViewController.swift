//
//  NewCategory_Goal_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class NewCategory_Goal_ViewController: UIViewController {
    
    var new_category: Category_obj = Category_obj()
    var new_activity : Activity_obj?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(new_category)
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "segue_categoryCreated"){
            
            // saving in Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            // create a new entity
            let entity = NSEntityDescription.entity(forEntityName: "Category", in: context)
            let newElement = NSManagedObject(entity: entity!, insertInto: context)
            
            newElement.setValue(new_category.color, forKey: "colour")
            newElement.setValue("not defined", forKey: "goal")
            newElement.setValue(new_category.name, forKey: "name")
            newElement.setValue(false, forKey: "has_goal")

            // saving a entity
            do {
                try context.save()
            }catch {print("failed save!")}
            
            
            
            // passing arguments
            let passingArgument = segue.destination as? NewActivity_Category_ViewController
            passingArgument?.new_activity = new_activity
        }
        
    }
    
    
    
   
    
}

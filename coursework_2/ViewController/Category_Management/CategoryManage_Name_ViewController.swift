//
//  CategoryManage_Name_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class CategoryManage_Name_ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.green

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "segue_newCategoryName"){
            var new_category:Category_obj = Category_obj()
            new_category.name = textField.text!

            let passingArgument = segue.destination as? ColorCategory_ViewController
            passingArgument?.new_category = new_category

        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool{
        
        // check on the SEGUE ~~
        if identifier == "segue_newCategoryName"
        {
            var check_univocity : Bool = false
            
            if let name = textField.text{
                
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
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
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
                        }
                        else{
                            print("DUPLICATE")
                        }
                    } catch {
                        print("Failed")
                    }
                }
                
            }
            
            
            
            
            
            
            return check_univocity
            
        }
        else{
            // is the back segue
            return true;
            
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

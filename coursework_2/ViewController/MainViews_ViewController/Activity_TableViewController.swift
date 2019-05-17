//
//  Activity_TableViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData


struct tableViewCustom {
    var category : String = ""
    var category_color : String = ""
    var activities : [String] = []
}


class Activity_TableViewController: UITableViewController {

    
    
    
    var item : [Activity] = []
    var name_category : [String] = []
    
    var dictionary_category_activities : [String : [String]] = [:]
    var dictionary_cat_act : [tableViewCustom] = []
    
    var selected_item : Int = 0
    var editingAvailable = false
    
    @IBOutlet weak var button_edit: UIBarButtonItem!
    override func viewWillAppear(_ animated: Bool) {
        item.removeAll()
        populateList()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        print("HELLO --> \(item.count)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button_edit.isEnabled = false

    }
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dictionary_cat_act.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return self.item.count
       let categories = dictionary_cat_act[section]
       return categories.activities.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //-> NB SAME TYPE OF CELL
//        let item = self.item[indexPath.row]
//        cell.textLabel?.text = item.name!
//        //return cell
        
        let category_selection = self.dictionary_cat_act[indexPath.section]
        let activity_selection = category_selection.activities[indexPath.row]
        cell.textLabel?.text =  activity_selection
        return cell
        
        
    }
    
    let myColour : MyCustomColors = MyCustomColors()
    let categoryColor : CategoryColor = CategoryColor()
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let category_selection_color = self.dictionary_cat_act[section].category_color
        
        
        var category_hex_color : UIColor?
        var text_color : UIColor?
        if category_selection_color == categoryColor.blue{
            category_hex_color = myColour.blue
            text_color = myColour.light_yellow
        }
        if category_selection_color == categoryColor.green{
            category_hex_color = myColour.green
            text_color = myColour.light_yellow

        }
        if category_selection_color == categoryColor.yellow{
            category_hex_color = myColour.light_orange
            text_color = myColour.blue

        }
        if category_selection_color == categoryColor.red{
            category_hex_color = myColour.orange
            text_color = UIColor.white

        }
        
        
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = category_hex_color
            headerView.textLabel?.textColor = text_color
        }
    }
 
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category_selection = self.dictionary_cat_act[section].category
        return category_selection// formatted diaryDay.date
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func populateList(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(fetchRequest2) as! [Activity]
            for data in result {
                item.append(data)
                
                // dictionary population --------
                if var items = dictionary_category_activities[data.cateogry!.name!] {
                    items.append(data.name!)
                    dictionary_category_activities[data.cateogry!.name!] = items
                }
                else {
                    dictionary_category_activities[data.cateogry!.name!] = [data.name!]
                }
                
                
                if !name_category.contains(data.cateogry!.name!){
                    name_category.append(data.cateogry!.name!)
                }
                
                
                
                // arrey of struct in dictionary form
                
                
                if dictionary_cat_act.contains(where: {$0.category == data.cateogry!.name!}){
                    print(data.name!)
                    
                    for i in 0...dictionary_cat_act.count-1{
                        if dictionary_cat_act[i].category == data.cateogry!.name!{
                            dictionary_cat_act[i].activities.append(data.name!)
                        }
                    }

                }
                else{
                    var a : tableViewCustom = tableViewCustom()
                    a.category = data.cateogry!.name!
                    a.activities.append(data.name!)
                    a.category_color = data.cateogry!.colour!
                    dictionary_cat_act.append(a)
                }
                
                
                
                /// ---------------------------
                
            }
            
        } catch {
            
            print("Failed")
        }
        print("DICTIONARY")
        print(dictionary_category_activities)
        print(dictionary_cat_act)
        print(name_category)
    }
    

    // DELETE A ROW IN THE TABVIEW
    // DELETE CELL
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Warning", message: "Are you sure?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.delete_CoreData(indexPath: indexPath)
                
                self.item.remove(at: indexPath.row)
                
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
                
            })
            
            alertController.addAction(deleteAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func delete_CoreData(indexPath: IndexPath){
        print("YOO DELETING")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let temp = self.item[indexPath.row]
        let name : String = temp.value(forKey: "name") as! String
        print (name)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        // filtering
        // DELETE ACTIVITIES
        let filter = NSPredicate(format: "name == %@", name)
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
        } catch {
            print("Failed")
        }
        
        
        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")
        
        // filtering
        let filter2 = NSPredicate(format: "activity_name == %@", name)
        request2.predicate = filter2
        
        
        // doing the request -- fetching the request
        request2.returnsObjectsAsFaults = false
        do {
            print("YO - RESULT")
            let result = try context.fetch(request2)
            if (result.count > 0){
                let manage = result[0] as! NSManagedObject
                context.delete(manage)
                // saving a entity
                do {
                    try context.save()
                }catch {print("failed save!")}
            }
            else if (result.count == 0){          // delete it
                print("YO - NO ACTIVITIES WERE COMPLETED")
        }

            
        } catch {
            
            print("Failed")
        }

    
    }
    
    
    
    // check select item to modify
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected index \(indexPath.row)")
        self.selected_item = indexPath.row
        if editingAvailable == false{
            self.button_edit.isEnabled = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue_editActivity"){       
            let passingArgument = segue.destination as? NewActivity_Category_ViewController
            passingArgument?.oldActivity = item[self.selected_item]
            passingArgument?.editing_mode_on = true
        }
    }
    

}

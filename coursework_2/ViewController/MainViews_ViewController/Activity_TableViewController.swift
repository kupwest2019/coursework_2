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
    
    var selected_activity : Activity?
    var dictionary_cat_act : [tableViewCustom] = []

    
    
    
    
 //   var dictionary_category_activities : [String : [String]] = [:]
    
    var selected_item : Int = 0
    var editingAvailable = false
    
    @IBOutlet weak var button_edit: UIBarButtonItem!
    override func viewWillAppear(_ animated: Bool) {
        
        
        // -- EDITING NAV_BAR --//
        let nav = self.navigationController?.navigationBar
        // 2
        let myColor = MyCustomColors()
        // nav?.barStyle = UIBarStyle.blackOpaque
        nav?.backgroundColor = myColor.orange
        nav?.tintColor = myColor.blue
        let nav_bar : NavigationBarCustom = ChangeTextNavigationBarAttribute()
        self.navigationItem.titleView = nav_bar.textNavBarAttributes(color1: myColor.blue, text1: "ACTIVITIES", color2: UIColor.black, text2: "all")
        
        
        //
        editingAvailable = false
        item.removeAll()
        dictionary_cat_act.removeAll()
        name_category.removeAll()
        
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
       
        if dictionary_cat_act.count > 0{
            let categories = dictionary_cat_act[section]
            
            return categories.activities.count
        }
        else{
            return 0
        }
        
        
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
    
    let core_data : Core_Data_Interface = accessingCoreData()

    func populateList(){
        
        let result = core_data.returnAllActivities()
        self.item = result
        for data in result {
            
            print(data)
            guard let activity : Category = data.cateogry else {fatalError("Unexpected class type in allObjects")}
            guard let category_name : String = activity.name else {fatalError("Unexpected class type in allObjects")}
            
            if dictionary_cat_act.contains(where: {$0.category == category_name}){
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
        }
        
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
//        fetchRequest2.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(fetchRequest2) as! [Activity]
//            for data in result {
//                item.append(data)
//
//                if dictionary_cat_act.contains(where: {$0.category == data.cateogry!.name!}){
//                    print(data.name!)
//
//                    for i in 0...dictionary_cat_act.count-1{
//                        if dictionary_cat_act[i].category == data.cateogry!.name!{
//                            dictionary_cat_act[i].activities.append(data.name!)
//                        }
//                    }
//
//                }
//                else{
//                    var a : tableViewCustom = tableViewCustom()
//                    a.category = data.cateogry!.name!
//                    a.activities.append(data.name!)
//                    a.category_color = data.cateogry!.colour!
//                    dictionary_cat_act.append(a)
//                }
//
//
//
//                /// ---------------------------
//
//            }
//
//        } catch {
//
//            print("Failed")
//        }
        print("DICTIONARY")
       // print(dictionary_category_activities)
        print(dictionary_cat_act)
        print(name_category)
    }
    

    // DELETE A ROW IN THE TABVIEW
    // DELETE CELL - SECTIONS
    
    
    // variable to keep track if a section needs to be deleted
    var sectionDeleted : Bool = false
    
    func updateCoreData_updateTable(indexPath : IndexPath){
        // REMOVE FROM CORE DATA
        self.delete_CoreData(indexPath: indexPath)
        
        sectionDeleted = false
        // remove from data structure.
        self.item.remove(at: indexPath.row)
        
        // identification of the element from the structure and delete.
        let z = self.dictionary_cat_act[indexPath.section].activities[indexPath.row]
        var index_to_be_deleted:Int?
        for i in self.dictionary_cat_act{
            for a in i.activities{
                if a == z{
                    index_to_be_deleted = i.activities.firstIndex(of: z)
                }
            }
        }
        
        
        // delete by index of string in arrey of string.
        self.dictionary_cat_act[indexPath.section].activities.remove(at: index_to_be_deleted!)
        if self.dictionary_cat_act[indexPath.section].activities.count == 0{
            let index_of_category = self.dictionary_cat_act.firstIndex(where: {$0.category == self.dictionary_cat_act[indexPath.section].category})
            self.dictionary_cat_act.remove(at: index_of_category!)
            self.sectionDeleted = true
            
        }
        
        self.tableView.beginUpdates()
        if self.sectionDeleted == true{
            print("a section was deleted")
            self.tableView.deleteSections([indexPath.section], with: .fade)
        }
        if self.sectionDeleted == false{
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        self.tableView.endUpdates()
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Warning", message: "Are you sure?", preferredStyle: .alert)
            
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    
                self.updateCoreData_updateTable(indexPath: indexPath)
                    
                
            })
            
            alertController.addAction(deleteAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func delete_CoreData(indexPath: IndexPath){
        print("YOO DELETING")
        
        //        let temp = self.item[indexPath.row]
        //
        //        let name : String = temp.value(forKey: "name") as! String
        
        let name_activity : String = self.dictionary_cat_act[indexPath.section].activities[indexPath.row]
        
        print ("TO BE DELETED --> \(name_activity)")
        core_data.deleteActivity(name_activity: name_activity)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
////        let temp = self.item[indexPath.row]
////
////        let name : String = temp.value(forKey: "name") as! String
//
//        let name_activity : String = self.dictionary_cat_act[indexPath.section].activities[indexPath.row]
//
//
//        print (name_activity)
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
//
//        // filtering
//        // DELETE ACTIVITIES
//        let filter = NSPredicate(format: "name == %@", name_activity)
//        request.predicate = filter
//
//        // doing the request -- fetching the request
//        request.returnsObjectsAsFaults = false
//        do {
//            print("YO - RESULT")
//            let result = try context.fetch(request)
//            if (result.count > 0){
//                let manage = result[0] as! NSManagedObject
//                context.delete(manage)
//                // saving a entity
//                do {
//                    try context.save()
//                }catch {print("failed save!")}
//            }
//        } catch {
//            print("Failed")
//        }
//
//
//        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")
//
//        // filtering
//        let filter2 = NSPredicate(format: "activity_name == %@", name_activity)
//        request2.predicate = filter2
//
//
//        // doing the request -- fetching the request
//        request2.returnsObjectsAsFaults = false
//        do {
//            print("YO - RESULT")
//            let result = try context.fetch(request2)
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
//        }
//
//
//        } catch {
//
//            print("Failed")
//        }

    
    }
    
    
    
    // check select item to modify
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected index : row \(indexPath.row) :section \(indexPath.section)")
        self.selected_item = indexPath.row
        let name_activity : String = self.dictionary_cat_act[indexPath.section].activities[indexPath.row]
        for index in item{
            if index.name == name_activity{
                self.selected_activity = index
            }
        }

        if editingAvailable == false{
            self.button_edit.isEnabled = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue_editActivity"){       
            let passingArgument = segue.destination as? NewActivity_Category_ViewController
            passingArgument?.oldActivity = self.selected_activity!
            passingArgument?.editing_mode_on = true
        }
    }
    

}

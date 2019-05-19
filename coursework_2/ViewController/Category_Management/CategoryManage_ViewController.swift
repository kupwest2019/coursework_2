//
//  CategoryManage_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class CategoryManage_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    @IBOutlet weak var navBar: UINavigationBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //-> NB SAME TYPE OF CELL
        let item = self.activities[indexPath.row]
        cell.textLabel?.text = item.name!
        return cell
    }
    
    var activities : [Category] = []
    @IBOutlet weak var tabView: UITableView!
    var selected_item : Int = 0
    var editingAvailable = false
    
    @IBOutlet weak var editingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
       

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // self.registerCustomCell()
        editingAvailable = false
        activities.removeAll()
        
        self.editingButton.isEnabled = false
        self.tabView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tabView.dataSource = self
        self.tabView.delegate = self
        
        populateList()
    }
    
    
    func registerCustomCell(){
        let textFieldCell = UINib(nibName: "CustomCellTabView", bundle: nil)
        self.tabView.register(textFieldCell, forCellReuseIdentifier: "CustomCellTabView")
    }
    
    func populateList(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
        //        let filter = NSPredicate(format: "name == %@", textFiled_activityName.text!)
        //        request.predicate = filter
        
        // doing the request -- fetching the request
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(fetchRequest2) as! [Category]
            for data in result {
                print(data)
                activities.append(data)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "editing"){
            
            let selectedCategory = self.activities[selected_item]
            
            let passingArgument = segue.destination as? ColorCategory_ViewController
            passingArgument?.edit_category = selectedCategory
            passingArgument?.editingRequest = true
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Warning", message: "Are you sure?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    self.deleteRequest(indexPath: indexPath)
            })
            
            alertController.addAction(deleteAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }

    }
    
    
    
    
    func checkActivityPredifined(_ nameCategory: String) -> Bool{
        var check = false
        let predifinedActivities : PredifinedCategory = PredifinedCategory()
        if (nameCategory == predifinedActivities.amuse || nameCategory == predifinedActivities.exercise || nameCategory == predifinedActivities.health || nameCategory == predifinedActivities.study){
            check = true
        }
        
        return check
    }
    
    
    
    func deleteRequest(indexPath: IndexPath){
        
        let temp = self.activities[indexPath.row]
        let name : String = temp.value(forKey: "name") as! String
        if(checkActivityPredifined(name)){
            print("ERROR! Category is a predifined!")
            let alertController = UIAlertController(title: "Warning", message: "Category is a predifined!!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }
        else if(checkActivitiesRelated(name)){
            print("ERROR! Category is used!")
            let alertController = UIAlertController(title: "Warning", message: "Category is associated by an Activity", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        else{
            self.delete_CoreData(indexPath: indexPath, name: name)
            self.activities.remove(at: indexPath.row)
            self.tabView.beginUpdates()
            self.tabView.deleteRows(at: [indexPath], with: .automatic)
            self.tabView.endUpdates()
        }

    }
    
    
    
    func delete_CoreData(indexPath: IndexPath, name : String) {
        print("YOO DELETING")
        
        
        
       
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
            
            // filtering
            //request.predicate = NSPredicate(format: "age = %@", "12")
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
                
                //            for data in result as! [NSManagedObject] {
                //                print(data.value(forKey: "name") as! String)
                //            }
                
            } catch {
                
                print("Failed")
            }
            
           
    }
        
  
    
    func checkActivitiesRelated(_ nameCategory: String) -> Bool{
        
        var categoryIsUsed: Bool = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
//        let filter = NSPredicate(format: "name == %@", name)
//        request.predicate = filter
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
            print("YO - RESULT")
            
            
            let result = try context.fetch(request) as! [Activity]
            for data in result {
                if(data.cateogry?.name == nameCategory){
                    print("CATEGORY IS USED")
                    categoryIsUsed = true
                }
                
            }
        } catch {
            
            print("Failed")
        }
        
        return categoryIsUsed
        
    }
    
    
    // check select item to modify
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        print("selected index \(indexPath.row)")
        self.selected_item = indexPath.row
        if editingAvailable == false{
            self.editingButton.isEnabled = true
        }
        
        
    }
}

    
    

   



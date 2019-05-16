//
//  Activity_TableViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class Activity_TableViewController: UITableViewController {

    
    
    
    
    
    
    var item : [Activity] = []
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

    // MARK: - Table view data source

    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
//    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let vw = UIView()
//        vw.backgroundColor = UIColor.red
//        return vw
//    }
//    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //-> NB SAME TYPE OF CELL
        let item = self.item[indexPath.row]
        cell.textLabel?.text = item.name!
        return cell
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
            }
            
        } catch {
            
            print("Failed")
        }
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

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
        populateList()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.button_edit.isEnabled = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.item.count
    }
    
    
    func populateList(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
        //        let filter = NSPredicate(format: "name == %@", textFiled_activityName.text!)
        //        request.predicate = filter
        
        // doing the request -- fetching the request
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //-> NB SAME TYPE OF CELL
        let item = self.item[indexPath.row]
        cell.textLabel?.text = item.name!
        return cell
    }

    
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    // DELETE A ROW IN THE TABVIEW
    // DELETE CELL
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Warning", message: "Are you sure?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.rowDownload(indexPath: indexPath)
            })
            
            alertController.addAction(deleteAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func rowDownload(indexPath: IndexPath){
        print("YOO DELETING")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let temp = self.item[indexPath.row]
        let name : String = temp.value(forKey: "name") as! String
        print (name)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
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
        
        self.item.remove(at: indexPath.row)
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
    
    
    
    // check select item to modify
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let indexPath = tableView.indexPathForSelectedRow() //optional, to get from any UIButton for example
//        let currentCell = tableView.cellForRow(at: indexPath) as! UITableViewCell
//        print(currentCell.textLabel!.text!)
        
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
    
    // DELETE A ROW IN THE TABVIEW

    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

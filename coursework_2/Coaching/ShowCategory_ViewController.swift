//
//  ShowCategory_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 17/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class ShowCategory_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    var selected_item : Int = 0
    var editingAvailable = false
    
    @IBOutlet weak var editingButton: UIBarButtonItem!
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // self.registerCustomCell()
        activities.removeAll()
        
        self.editingButton.isEnabled = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        populateList()
    }
    
    func registerCustomCell(){
        let textFieldCell = UINib(nibName: "CustomCellTabView", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "CustomCellTabView")
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
        
        if(segue.identifier == "goalDetail"){
            
            let selectedCategory = self.activities[selected_item]
            
            let passingArgument = segue.destination as? ShowGoalDeail_ViewController
            passingArgument?.edit_category = selectedCategory
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("selected index \(indexPath.row)")
        self.selected_item = indexPath.row
        if editingAvailable == false{
            self.editingButton.isEnabled = true
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

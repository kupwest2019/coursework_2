//
//  ToDoToday_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 16/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class ToDoToday_ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    var item : [Activity] = []
    var selected_item : Int = 0
    var editingAvailable = false
    
    override func viewWillAppear(_ animated: Bool) {
        populateList()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(item)
        
        
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
       
        let today : Date = Date()
        let date_helper : DealWithDate = DealWithDate()
        
        let today_start = date_helper.returnOnlyDayMonthYear(inputDate: today)
        let today_end = date_helper.returnOnlyDayMonthYear_LastDate(inputDate: today)
        
        
        // NB PAY ATTENTION TO DATE
        let fromPredicate = NSPredicate(format: "end_date >= %@", today_start as NSDate)
        let toPredicate = NSPredicate(format: "start_date =< %@", today_end as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        
        
        
        fetchRequest2.predicate = datePredicate
        
        // doing the request -- fetching the request
        
        
        
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(fetchRequest2) as! [Activity]
            for data in result {
                populateScheduledActivities(activity: data , startDate: today_start, endDate: today_end)
                print(data)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func populateScheduledActivities(activity : Activity, startDate : Date, endDate : Date){
        
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
    
    
    
    
    // check select item to modify
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected index \(indexPath.row)")
        self.selected_item = indexPath.row
        if editingAvailable == false{
            self.editButton.isEnabled = true
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "next"){
            let passingArgument = segue.destination as? CompleteActivity_ViewController
            print(self.item[self.selected_item])
            
            passingArgument?.activityToBeExecuted = self.item[self.selected_item]
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

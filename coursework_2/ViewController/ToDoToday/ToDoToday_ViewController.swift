//
//  ToDoToday_ViewController.swift
//  coursework_2
//
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class ToDoToday_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let core_data : Core_Data_Interface = accessingCoreData()

    var counterDay : Int = 0
    
    let today : Date = Date()
    var today_date : Date?
    let date_helper : DealWithDate = DealWithDate()
    
    var elaboration_date: Date = Date()
    
    var item : [Activity] = []
    var completedActivity : [CompletedActivity] = []
    
    var toDoActivity : [Activity] = []
    var selected_item : Int = 0
    var editingAvailable = false

    @IBAction func button_next(_ sender: Any) {
        
        counterDay = counterDay+1
        clear_arrey_scheduled_activities()
        populateList()
        
        tableView.reloadData()
        
    }
    
    
    @IBAction func button_prev(_ sender: Any) {
        counterDay = counterDay-1
        clear_arrey_scheduled_activities()
        populateList()
        
        tableView.reloadData()

    }
    
    
    func clear_arrey_scheduled_activities(){
        toDoActivity.removeAll()
    }
    
    
    
    @IBOutlet weak var label_day: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.navigationController?.navigationBar
        
        // 2
        let myColor = MyCustomColors()
        // nav?.barStyle = UIBarStyle.blackOpaque
        nav?.backgroundColor = myColor.green
        nav?.tintColor = myColor.blue
        
        // 3
        
        let nav_bar : NavigationBarCustom = ChangeTextNavigationBarAttribute()
        self.navigationItem.titleView = nav_bar.textNavBarAttributes(color1: myColor.darkBrown, text1: "TOdo", color2: myColor.blue, text2: "TODAY")
        
        
        
        
    }
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.toDoActivity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //-> NB SAME TYPE OF CELL
        let item = self.toDoActivity[indexPath.row]
        cell.textLabel?.text = item.name!
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        editingAvailable = false
        self.editButton.isEnabled = false
        let today_is = Date()
        today_date = date_helper.returnOnlyDayMonthYear(inputDate: today_is)
        // Do any additional setup after loading the view.
        populateList()
        self.registerCustomCell()
    
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func registerCustomCell(){
        let textFieldCell = UINib(nibName: "CustomCellTabView", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "CustomCellTabView")
    }

    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func populateCompletedActivity(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")
//
        
        if let newDay = Calendar.current.date(byAdding: .day, value: self.counterDay, to: today){
            self.elaboration_date = newDay
        }
        
        let today_start = date_helper.returnOnlyDayMonthYear(inputDate: self.elaboration_date)
        let today_end = date_helper.returnOnlyDayMonthYear_LastDate(inputDate: self.elaboration_date)
       
        self.completedActivity = core_data.returnCompletedActivitiesTwoDates(start_date: today_start, end_date: today_end)
        
//
//        let fromPredicate = NSPredicate(format: "date >= %@", today_start as NSDate)
//        let toPredicate = NSPredicate(format: "date =< %@", today_end as NSDate)
//        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
//        fetchRequest2.predicate = datePredicate
//
//        // doing the request -- fetching the request
//
//        fetchRequest2.returnsObjectsAsFaults = false
//        do {
//
//            print("COMPLETED ACTIVITIES")
//            let result = try context.fetch(fetchRequest2) as! [CompletedActivity]
//            for data in result {
//                print(data)
//                self.completedActivity.append(data)
//            }
//
//        } catch {
//
//            print("Failed")
//        }
    }
    
    
    func populateDailyActivity(){
        
        
        var newDay = Calendar.current.date(byAdding: .day, value: self.counterDay, to: today)
        newDay = date_helper.returnOnlyDayMonthYear(inputDate: newDay!)
        self.elaboration_date = newDay!
        
        
        let today_start = date_helper.returnOnlyDayMonthYear(inputDate: newDay!)
        let today_end = date_helper.returnOnlyDayMonthYear_LastDate(inputDate: newDay!)
        
        let day_description = date_helper.returnCalendarDayMonthYear(inputDate: today_start)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: today_start)
        
        if (today_start == self.today_date){
            self.label_day.text = "Today Activities"
        }
        else{
            self.label_day.text = "\(dayInWeek) : \(day_description.day ?? 0) - \(day_description.month ?? 0) "
        }
        
        let results = core_data.return_To_Do_Activities_TwoDates(start_date: today_start, end_date: today_end)
        item = core_data.populateScheduledActivities(activities: results, startDate: today_start, endDate: today_end)

    }
    
    // loop to find the activity toDoToday
    func populateToDoActivity(){
        
        
        for activity in self.item{
            
            print("I AM VERIFYING")
            print(activity)
            
            
            var found: Bool = false
            
            for completed in self.completedActivity{
                if (completed.activity_name == activity.name){
                    found = true
                }
            }
            if (found == false){
                self.toDoActivity.append(activity)
            }
        }
    }
    
    
    func clearArreyList(){
        self.completedActivity.removeAll()
        self.item.removeAll()
        self.toDoActivity.removeAll()
    }
    
    
    func populateList(){
        clearArreyList()
        populateCompletedActivity()
        populateDailyActivity()
        populateToDoActivity()
        // reload the list
        tableView.reloadData()
    }
   
    
  
    // check select item to modify
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("selected index \(indexPath.row)")
        self.selected_item = indexPath.row
        if editingAvailable == false{
            self.editButton.isEnabled = true
        }


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "next"){
            let passingArgument = segue.destination as? CompleteActivity_ViewController
            print(self.toDoActivity[self.selected_item])
            
            passingArgument?.activityToBeExecuted = self.toDoActivity[self.selected_item]
            passingArgument?.dateOfActivity = self.elaboration_date
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


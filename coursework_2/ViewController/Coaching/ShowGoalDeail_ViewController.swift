//
//  ShowGoalDeail_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 17/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class ShowGoalDeail_ViewController: UIViewController {
    var edit_category: Category?
    let my_helper_dates : DealWithDate = DealWithDate()
    
    @IBOutlet weak var start_date: UILabel!
    @IBOutlet weak var label_categoryGoal: UILabel!
    
    @IBOutlet weak var label_not_completed_act: UILabel!
    @IBOutlet weak var label_completed_act: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let today : Date = Date()
    var all_the_activities : [Activity] = []
    var all_activities_goal_related : [Activity] = []
    var completed_activities : [CompletedActivity] = []
    
    func refreshData(){
        all_the_activities.removeAll()
        all_activities_goal_related.removeAll()
        completed_activities.removeAll()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        refreshData()
        loadAllData()
        loadAnimationView()
        
        
    }
    
    func loadAllData(){
        
        
        guard let category : Category = edit_category else {fatalError("Unexpected class type in allObjects")}
        guard let start_date : Date = category.startDate else {fatalError("Unexpected type")}
        
        let core_data : Core_Data_Interface = accessingCoreData()
        let today = Date()

        let result = core_data.returnCompletedActivitiesTwoDates(start_date: start_date, end_date: today)
        for data in result {
            if data.category == category.name{
                print(data)
                self.completed_activities.append(data)
            }
            
        }
//
//        let fromPredicate = NSPredicate(format: "date >= %@", edit_category!.startDate! as NSDate)
//        let toPredicate = NSPredicate(format: "date =< %@", today as NSDate)
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
//                if data.category == edit_category!.name{
//                    print(data)
//                    self.completed_activities.append(data)
//                }
//
//            }
//
//        } catch {
//
//            print("Failed")
//        }
//
//
//
        
        
    }
    
    @IBOutlet weak var label_remainingActivities: UILabel!
    
    func loadAnimationView(){
        let day_start = my_helper_dates.returnCalendarDayMonthYear(inputDate: edit_category!.startDate!)
        
        let goal_value = Int(self.edit_category!.goal)
       
        
        self.start_date.text = "\(day_start.year!) - \(day_start.month!) - \(day_start.day!)"
        self.label_categoryGoal.text = "\(goal_value)"
        
        self.label_completed_act.text = "\(completed_activities.count)"
        let notCompleted = goal_value - completed_activities.count
        self.label_not_completed_act.text = "\(notCompleted)"
        
        print(notCompleted)
        print(goal_value)
    
        if (notCompleted <= 0 && goal_value > 0){
            let myColor : MyCustomColors = MyCustomColors()
            self.label_remainingActivities.isHidden = true
            
            let quote = "CONGRATULATION! goal achived!"
            let font = UIFont.systemFont(ofSize: 20)
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.lightGray
            shadow.shadowBlurRadius = 5
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.black,
                .backgroundColor: myColor.green,
                .shadow: shadow
            ]
            let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
            self.label_not_completed_act.attributedText = attributedQuote
            
        }
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goalDetail"){

            let passingArgument = segue.destination as? ShowGoalCategory_ViewController
            passingArgument?.edit_category = edit_category
            
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

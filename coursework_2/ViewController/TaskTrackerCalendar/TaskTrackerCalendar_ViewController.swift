//
//  TaskTrackerCalendar_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class TaskTrackerCalendar_ViewController: UIViewController {

    var today : Date = Date()
    var calendar = Calendar.current
    var counter : Int = 0
    
    var totalNumberOfDaysInAMonth : Int = 0
    var existsActivityScheduledForTheMonth : Bool = false
    
    var arreyButton : [RoundButtonDesignable] = []
    var arrey_scheduled_activities : [Calendar_Day_Activity] = []
    var actualButton : RoundButtonDesignable?


    
    
    @IBOutlet weak var label_yearmonth: UILabel!
    
    // days var
    @IBOutlet weak var day01: RoundButtonDesignable!
    @IBOutlet weak var day02: RoundButtonDesignable!
    @IBOutlet weak var day06: RoundButtonDesignable!
    @IBOutlet weak var day11: RoundButtonDesignable!
    @IBOutlet weak var day16: RoundButtonDesignable!
    @IBOutlet weak var day21: RoundButtonDesignable!
    @IBOutlet weak var day26: RoundButtonDesignable!
    @IBOutlet weak var day31: RoundButtonDesignable!
    @IBOutlet weak var day07: RoundButtonDesignable!
    @IBOutlet weak var day12: RoundButtonDesignable!
    @IBOutlet weak var day17: RoundButtonDesignable!
    @IBOutlet weak var day22: RoundButtonDesignable!
    @IBOutlet weak var day27: RoundButtonDesignable!
    @IBOutlet weak var day03: RoundButtonDesignable!
    @IBOutlet weak var day08: RoundButtonDesignable!
    @IBOutlet weak var day13: RoundButtonDesignable!
    @IBOutlet weak var day18: RoundButtonDesignable!
    @IBOutlet weak var day23: RoundButtonDesignable!
    @IBOutlet weak var day28: RoundButtonDesignable!
    @IBOutlet weak var day04: RoundButtonDesignable!
    @IBOutlet weak var day09: RoundButtonDesignable!
    @IBOutlet weak var day14: RoundButtonDesignable!
    @IBOutlet weak var day19: RoundButtonDesignable!
    @IBOutlet weak var day24: RoundButtonDesignable!
    @IBOutlet weak var day29: RoundButtonDesignable!
    @IBOutlet weak var day05: RoundButtonDesignable!
    @IBOutlet weak var day10: RoundButtonDesignable!
    @IBOutlet weak var day15: RoundButtonDesignable!
    @IBOutlet weak var day20: RoundButtonDesignable!
    @IBOutlet weak var day25: RoundButtonDesignable!
    @IBOutlet weak var day30: RoundButtonDesignable!
    
    
    
    func populateArreyButton(){
        arreyButton.append(day01)
        arreyButton.append(day02)
        arreyButton.append(day03)
        arreyButton.append(day04)
        arreyButton.append(day05)
        arreyButton.append(day06)
        arreyButton.append(day07)
        arreyButton.append(day08)
        arreyButton.append(day09)
        arreyButton.append(day10)
        arreyButton.append(day11)
        arreyButton.append(day12)
        arreyButton.append(day13)
        arreyButton.append(day14)
        arreyButton.append(day15)
        arreyButton.append(day16)
        arreyButton.append(day17)
        arreyButton.append(day18)
        arreyButton.append(day19)
        arreyButton.append(day20)
        arreyButton.append(day21)
        arreyButton.append(day22)
        arreyButton.append(day23)
        arreyButton.append(day24)
        arreyButton.append(day25)
        arreyButton.append(day26)
        arreyButton.append(day27)
        arreyButton.append(day28)
        arreyButton.append(day29)
        arreyButton.append(day30)
        arreyButton.append(day31)
    }

    
    
    // tracking activities - calendar
    var day01_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 01)
    var day02_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 02)
    var day03_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 03)
    var day04_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 04)
    var day05_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 05)
    var day06_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 06)
    var day07_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 07)
    var day08_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 08)
    var day09_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 09)
    var day10_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 10)
    var day11_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 11)
    var day12_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 12)
    var day13_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 13)
    var day14_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 14)
    var day15_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 15)
    var day16_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 16)
    var day17_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 17)
    var day18_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 18)
    var day19_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 19)
    var day20_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 20)
    var day21_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 21)
    var day22_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 22)
    var day23_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 23)
    var day24_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 24)
    var day25_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 25)
    var day26_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 26)
    var day27_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 27)
    var day28_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 28)
    var day29_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 29)
    var day30_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 30)
    var day31_tracking : Calendar_Day_Activity = Calendar_Day_Activity(day: 31)
    

    func populateArreyScheduledActivities(){
        arrey_scheduled_activities.append(day01_tracking)
        arrey_scheduled_activities.append(day02_tracking)
        arrey_scheduled_activities.append(day03_tracking)
        arrey_scheduled_activities.append(day04_tracking)
        arrey_scheduled_activities.append(day05_tracking)
        arrey_scheduled_activities.append(day06_tracking)
        arrey_scheduled_activities.append(day07_tracking)
        arrey_scheduled_activities.append(day08_tracking)
        arrey_scheduled_activities.append(day09_tracking)
        arrey_scheduled_activities.append(day10_tracking)
        arrey_scheduled_activities.append(day11_tracking)
        arrey_scheduled_activities.append(day12_tracking)
        arrey_scheduled_activities.append(day13_tracking)
        arrey_scheduled_activities.append(day14_tracking)
        arrey_scheduled_activities.append(day15_tracking)
        arrey_scheduled_activities.append(day16_tracking)
        arrey_scheduled_activities.append(day17_tracking)
        arrey_scheduled_activities.append(day18_tracking)
        arrey_scheduled_activities.append(day19_tracking)
        arrey_scheduled_activities.append(day20_tracking)
        arrey_scheduled_activities.append(day21_tracking)
        arrey_scheduled_activities.append(day22_tracking)
        arrey_scheduled_activities.append(day23_tracking)
        arrey_scheduled_activities.append(day24_tracking)
        arrey_scheduled_activities.append(day25_tracking)
        arrey_scheduled_activities.append(day26_tracking)
        arrey_scheduled_activities.append(day27_tracking)
        arrey_scheduled_activities.append(day28_tracking)
        arrey_scheduled_activities.append(day29_tracking)
        arrey_scheduled_activities.append(day30_tracking)
        arrey_scheduled_activities.append(day31_tracking)
   
    }
    
    // clear the scheudle activities while the month is changing
    func clear_arrey_scheduled_activities(){
        for index in 0...arrey_scheduled_activities.count-1{
            arrey_scheduled_activities[index].activities_scheduled.removeAll()
        }
    }
    
    // days func
    @IBAction func next(_ sender: UIButton) {
        counter = counter+1
        clear_arrey_scheduled_activities()
        updateDays(counter)
    }
    
    
    
    @IBAction func prev(_ sender: UIButton) {
        counter = counter-1
        clear_arrey_scheduled_activities()
        updateDays(counter)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateArreyButton()
        populateArreyScheduledActivities()
        updateDays(counter)
        setButtonSelectable()
        
        

        // Do any additional setup after loading the view.
    }
    
    // set the button target for selection
    func setButtonSelectable(){
        for i in arreyButton{
            i.addTarget(self, action: #selector(myButtonTapped(sender:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    
    
    // select button
    @objc func myButtonTapped(sender : RoundButtonDesignable){
        
        var i = 0
        
        // clean other button
        if let buttonSelected = actualButton{
            
            if buttonSelected == sender {
                print("you are still in the same button")
            }
            else{
                print("claen Button")

                while (i<totalNumberOfDaysInAMonth){
                    arreyButton[i].borderColor = UIColor.orange
                    arreyButton[i].isSelected = false
                    i = i+1
                }
            }
        }
        
        
        // manage select - unselect
        actualButton = sender
        if sender.isSelected == true{
            print("deselected")
            sender.isSelected = false
            sender.borderColor = UIColor.orange

            
        }
        else{
            print("selected")
            sender.isSelected = true
            sender.borderColor = UIColor.red

        }
    }
    
    
    func updateDays(_ counter : Int) {

        let newMonth = Calendar.current.date(byAdding: .month, value: counter, to: today)
        
        let range = calendar.range(of: .day, in: .month, for: newMonth!)
        let numDays = range?.count
        totalNumberOfDaysInAMonth = numDays!

        let calanderDate = Calendar.current.dateComponents([.year, .month], from: newMonth!)
        label_yearmonth.text = "\(calanderDate.month!) - \(calanderDate.year!)"
        
        // query activities -> populate activities to be executed arrey
        queryActivitis(newMonth!, numDays!)
        
        
        var day : Int = 0
        
        for i in arreyButton{
            i.backgroundColor = UIColor.white
            i.isEnabled = false
            i.isOpaque = true
            i.borderColor = UIColor.white

        }
        
        while(day<numDays!){
            arreyButton[day].backgroundColor = UIColor.lightGray
            arreyButton[day].isEnabled = true
            arreyButton[day].isOpaque = false
            arreyButton[day].borderColor = UIColor.orange
            day = day+1
            
        }
        
        refreshCalendarView()
        
    }
    
    
    func queryActivitis(_ newDate : Date, _ days:Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")

        
        let date_helper : DealWithDate = DealWithDate()
        let startDate = date_helper.returnOnlyDayMonthYear_customDay(inputDate: newDate, day: 1)
        let endDate = date_helper.returnOnlyDayMonthYear_customDay_endDate(inputDate: newDate, day: days)


        let fromPredicate = NSPredicate(format: "end_date >= %@", startDate as NSDate)
        let toPredicate = NSPredicate(format: "start_date < %@", endDate as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        request.predicate = datePredicate
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print("number of occurence present present --> ", result.count)
            
            for i in result{
                populateScheduledActivities(activity: i as! Activity, maxDay: days, startDate: startDate, endDate: endDate)
                
            }
            
        } catch {
            print("Failed")
        }
    }

    func populateScheduledActivities(activity : Activity, maxDay : Int, startDate : Date, endDate : Date){
        
        let date_helper : DealWithDate = DealWithDate()
        
        let startdate_activity = date_helper.returnOnlyDayMonthYear(inputDate: activity.start_date!)
        let enddate_activity = date_helper.returnOnlyDayMonthYear_LastDate(inputDate: activity.end_date!)
        
        if (activity.monthly == true){
            
            var newValue = Calendar.current.date(byAdding: .month, value: 0, to: startdate_activity)
            
            while(newValue! <= enddate_activity && newValue! <= endDate){
          
                
                print("Evaluation Date --> \(newValue!)")
                print("Activity Start --> \(startdate_activity)")
                print("Activity End --> \(enddate_activity)")
                
                // check if consider the activity
                if (newValue! >= startdate_activity && newValue! <= enddate_activity
                    && newValue! >= startDate && newValue! <= endDate){
                    
                    addToScheduledActivities(activity: activity, day: newValue!)
                    existsActivityScheduledForTheMonth = true
                }
                
                newValue = Calendar.current.date(byAdding: .month, value: 1, to: newValue!)
            
            }
            
        }
        else if (activity.daily == true){
            
            var newValue = Calendar.current.date(byAdding: .day, value: 0, to: startdate_activity)
            
            // < end_date of activity (2099 if infinite) && end_date month
            while(newValue! <= enddate_activity && newValue! <= endDate){
                
                
                print("Evaluation Date --> \(newValue!)")
                print("Activity Start --> \(startdate_activity)")
                print("Activity End --> \(enddate_activity)")
                
                // check if consider the activity
                if (newValue! >= startdate_activity && newValue! <= enddate_activity
                    && newValue! >= startDate && newValue! <= endDate){
                    
                    addToScheduledActivities(activity: activity, day: newValue!)
                    existsActivityScheduledForTheMonth = true
                }
                
                newValue = Calendar.current.date(byAdding: .day, value: 1, to: newValue!)
                
            }
            
            
        }
        else if (activity.weekly == true){
            var newValue = Calendar.current.date(byAdding: .day, value: 0, to: startdate_activity)
            
            // < end_date of activity (2099 if infinite) && end_date month
            while(newValue! <= enddate_activity && newValue! <= endDate){
                
                
                print("Evaluation Date --> \(newValue!)")
                print("Activity Start --> \(startdate_activity)")
                print("Activity End --> \(enddate_activity)")
                
                // check if consider the activity
                if (newValue! >= startdate_activity && newValue! <= enddate_activity
                    && newValue! >= startDate && newValue! <= endDate){
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEEE"
                    let dayInWeek = dateFormatter.string(from: newValue!)
                    
                    if(dayInWeek == "Sunday" && activity.sunday == true){
                        addToScheduledActivities(activity: activity, day: newValue!)
                        existsActivityScheduledForTheMonth = true
                    }
                    else if(dayInWeek == "Monday" && activity.monday == true){
                        addToScheduledActivities(activity: activity, day: newValue!)
                        existsActivityScheduledForTheMonth = true
                    }
                    else if(dayInWeek == "Tuesday" && activity.tuesday == true){
                        addToScheduledActivities(activity: activity, day: newValue!)
                        existsActivityScheduledForTheMonth = true
                    }
                    else if(dayInWeek == "Wednesday" && activity.wednseday == true){
                        addToScheduledActivities(activity: activity, day: newValue!)
                        existsActivityScheduledForTheMonth = true
                    }
                    else if(dayInWeek == "Thursday" && activity.thursday == true){
                        addToScheduledActivities(activity: activity, day: newValue!)
                        existsActivityScheduledForTheMonth = true
                    }
                    else if(dayInWeek == "Friday" && activity.friday == true){
                        addToScheduledActivities(activity: activity, day: newValue!)
                        existsActivityScheduledForTheMonth = true
                    }
                    else if(dayInWeek == "Saturday" && activity.saturday == true){
                        addToScheduledActivities(activity: activity, day: newValue!)
                        existsActivityScheduledForTheMonth = true
                    }
  
                }
                
                newValue = Calendar.current.date(byAdding: .day, value: 1, to: newValue!)
                
            }
        }
        
    }
    
    
    // add activity in a specific day
    func addToScheduledActivities(activity : Activity, day: Date){
        print("Activity must be executed in \(day)")
        
        for index in 0...arrey_scheduled_activities.count-1{
            
            let date_helper : DealWithDate = DealWithDate()
            let date_to_be_executed = date_helper.returnCalendarDayMonthYear(inputDate: day)
            
            if (arrey_scheduled_activities[index].day_number == date_to_be_executed.day){
                print("Acitivity will be executed in \(arrey_scheduled_activities[index].day_number)")
                arrey_scheduled_activities[index].activities_scheduled.append(activity)
                
                //i.activities_scheduled.append(activity)
            }
        }

    }
    
    func refreshCalendarView(){
        
        if(existsActivityScheduledForTheMonth){
            for index in 0...totalNumberOfDaysInAMonth-1{
                if (arrey_scheduled_activities[index].activities_scheduled.count > 0){
                    arreyButton[index].backgroundColor = UIColor.magenta
                }
            }
        }
        else{
            for index in 0...totalNumberOfDaysInAMonth-1{
                arreyButton[index].backgroundColor = UIColor.lightGray
                
            }
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var goAhead : Bool = false
        
        if (actualButton?.isSelected == true){
            goAhead = true
        }
        
        
        return goAhead
    }
    
    
    // segue policy
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "selectedDay"){
            let passingArgument = segue.destination as? ViewDetailTracker_ViewController
            
            if let index = arreyButton.firstIndex(of: actualButton!){
                print (index)
                passingArgument?.selectedDAyInfo = arrey_scheduled_activities[index]
            }
            
            
            
        }
    }

}

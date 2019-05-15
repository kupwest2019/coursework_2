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
    
    var arreyButton : [RoundButtonDesignable] = []
    
    
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

    // days func
    @IBAction func next(_ sender: UIButton) {
        counter = counter+1
        updateDays(counter)
    }
    
    
    
    @IBAction func prev(_ sender: UIButton) {
        counter = counter-1
        updateDays(counter)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateArreyButton()
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
    var actualButton : RoundButtonDesignable?
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
        
        queryActivitis(calanderDate.month!, calanderDate.year!, numDays!)
        
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
    }
    
    
    func queryActivitis(_ month : Int, _ year: Int, _ days:Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        // filtering
        //request.predicate = NSPredicate(format: "age = %@", "12")
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan Standard Time
        dateComponents.hour = 0
        dateComponents.minute = 00
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let startDate = userCalendar.date(from: dateComponents)
        
        
        dateComponents.day = days
        let endDate = userCalendar.date(from: dateComponents)

        let fromPredicate = NSPredicate(format: "end_date >= %@", startDate! as NSDate)
        let toPredicate = NSPredicate(format: "start_date < %@", endDate! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        request.predicate = datePredicate
        
        // doing the request -- fetching the request
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print("number of occurence present present --> ", result.count)
            
            for i in result{
                print(i)
            }
            
        } catch {
            print("Failed")
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

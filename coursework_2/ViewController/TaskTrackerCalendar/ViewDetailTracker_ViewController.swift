//
//  ViewDetailTracker_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class ViewDetailTracker_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if tableView == tabView_All{
            return 1
        }
        if tableView == self.tabView_completed{
            return 1
        }
        
        
        return 0

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if tableView == tabView_All{
            return self.scheduled_activities.count
        }
        if tableView == self.tabView_completed{
            return self.completed_activities.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tabView_All{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //-> NB SAME TYPE OF CELL
            let item = self.scheduled_activities[indexPath.row]
            cell.textLabel?.text = item.name!
            return cell
        }
        else if tableView == self.tabView_completed{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //-> NB SAME TYPE OF CELL
            let item = self.completed_activities[indexPath.row]
            cell.textLabel?.text = item.activity_name!
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //-> NB SAME TYPE OF CELL
        return cell
    }
    
    @IBOutlet weak var tabView_completed: UITableView!
    @IBOutlet weak var tabView_All: UITableView!
    
    @IBOutlet weak var animation: TrackerChart!
    
    override func viewWillDisappear(_ animated: Bool) {
        timer!.invalidate()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HEllo")
        scheduled_activities = selectedDAyInfo!.activities_scheduled
        completed_activities = selectedDAyInfo!.activities_finished
        
        self.registerCustomCell()
        
        self.tabView_All.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tabView_All.dataSource = self
        self.tabView_completed.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tabView_completed.dataSource = self
        
        // ANIMATION
        self.animation.completedActivities = 0.0
        self.animation.notCompletedActivities = 0.0
        
        calculateNotCompleted()
        
        moveTheAnimation()
    }
    var notCompletedRatio : CGFloat = 0.0
    var completedRatio : CGFloat = 0.0

    func calculateNotCompleted(){
        let activitiesCompleted = Float(completed_activities.count)
        let activitiesScheduled = Float(scheduled_activities.count)
        let notCompletedActivities = Float(activitiesScheduled - activitiesCompleted)
        let notCompletedRatioInt : Float = (notCompletedActivities / activitiesScheduled)
        let completeRatioInt : Float = (activitiesCompleted / activitiesScheduled)
        
        print(activitiesCompleted)
        print(activitiesScheduled)
        print(notCompletedActivities)
        print(notCompletedActivities)
        print(notCompletedRatioInt)
        print(completeRatioInt)
        
        
        notCompletedRatio = CGFloat(notCompletedRatioInt)
        completedRatio = CGFloat(completeRatioInt)
    }
    
    
    
    var index : CGFloat = 0.0
    var timer : Timer?
    
    
    func moveTheAnimation(){

        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        timer!.fire()
        print(self.completedRatio)
        print(self.notCompletedRatio)
        
    }

    
    // using the timer to re-draw
    @objc func fireTimer() {
     //   print("Timer fired!")
        
        if(index<1){
            index = index+0.003
         //   print(index)
            if (index < self.completedRatio){
                self.animation.completedActivities = index

            }
            if (index < self.notCompletedRatio){
                self.animation.notCompletedActivities = index

            }
        }
        else{
      //      print(index)
            index = index+1
            timer!.invalidate()
        //    print("Timer Stop")
        }
    }
    
    var selectedDAyInfo : Calendar_Day_Activity?
    var scheduled_activities : [Activity] = []
    var completed_activities : [CompletedActivity] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedDAyInfo)
      
        
    
        // Do any additional setup after loading the view.
    }
    

    func registerCustomCell(){
        let textFieldCell = UINib(nibName: "CustomCellTabView", bundle: nil)
        self.tabView_All.register(textFieldCell, forCellReuseIdentifier: "CustomCellTabView")
    }

}

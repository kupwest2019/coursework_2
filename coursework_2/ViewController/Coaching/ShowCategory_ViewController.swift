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
    var completedAmuse : [CompletedActivity] = []
    var completedExercise : [CompletedActivity] = []
    var completedStudy : [CompletedActivity] = []
    var completedHealth : [CompletedActivity] = []
    

    var activities : [Category] = []

    
    func calculateAnimationValue(){
        var max : Int = 0
        if completedExercise.count > max{
            max = completedExercise.count
        }
        if completedAmuse.count > max{
            max = completedExercise.count
        }
        if completedStudy.count > max{
            max = completedExercise.count
        }
        if completedHealth.count > max{
            max = completedExercise.count
        }
        
        
        
        
    }
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // self.registerCustomCell()
        activities.removeAll()
         completedAmuse.removeAll()
         completedExercise.removeAll()
         completedStudy.removeAll()
         completedHealth.removeAll()
        
        self.editingButton.isEnabled = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        loadAllData()
        populateList()
        showAnimation()
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
    
    
    func loadAllData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        //let newDay = Calendar.current.date(byAdding: .day, value: self.counterDay, to: today)
        //self.elaboration_date = newDay!
        
        
        // COMPLETED ACTIVITIES
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedActivity")
        let predifinedCategory : PredifinedCategory = PredifinedCategory()
        
        fetchRequest2.returnsObjectsAsFaults = false
        do {
            
            print("COMPLETED ACTIVITIES")
            let result = try context.fetch(fetchRequest2) as! [CompletedActivity]
            for data in result {
                print(data)
                
                if (data.category == predifinedCategory.amuse){
                        self.completedAmuse.append(data)
                }
                else if (data.category == predifinedCategory.exercise){
                    self.completedExercise.append(data)

                }
                else if (data.category == predifinedCategory.health) {
                    self.completedHealth.append(data)

                }
                else if (data.category == predifinedCategory.study ) {
                    self.completedStudy.append(data)

                }
                
            }
            
        } catch {
            
            print("Failed")
        }
 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    
    var timer : Timer?
    var index : CGFloat = 0.0
    var counter_timer : CGFloat = 0.0
    var movement_tick : CGFloat = 0.0
    
    var amuseGoal : Int = 0
    var exercizeGoal : Int = 0
    var healthGoal : Int = 0
    var studyGoal : Int = 0
    
    var completedAmuseTrigger : CGFloat = 0.0
    var completedExercizeTrigger : CGFloat = 0.0
    var completedHealthTrigger : CGFloat = 0.0
    var completedStudyTrigger : CGFloat = 0.0


    
    @IBOutlet weak var animation: FourCategories!
    func showAnimation(){
        
        let predefinedCategories : PredifinedCategory = PredifinedCategory()
        
        for item in activities{
            print(item)
            if item.name == predefinedCategories.amuse{
                amuseGoal = Int(item.goal)
            }
            if item.name == predefinedCategories.exercise{
                exercizeGoal = Int(item.goal)
            }
            if item.name == predefinedCategories.health{
                healthGoal = Int(item.goal)
            }
            if item.name == predefinedCategories.study{
                studyGoal = Int(item.goal)
            }
        }
        
        
        print(amuseGoal)
        print(exercizeGoal)
        print(healthGoal)
        print(studyGoal)
        
        if amuseGoal > 0{
            completedAmuseTrigger = CGFloat(Float(self.completedAmuse.count) / Float(amuseGoal))
        }
        if exercizeGoal > 0 {
            completedExercizeTrigger = CGFloat(Float(self.completedExercise.count) / Float(exercizeGoal))

        }
        if healthGoal > 0{
            completedHealthTrigger = CGFloat(Float(self.completedHealth.count) / Float(healthGoal))

        }
        if studyGoal > 0{
            completedStudyTrigger = CGFloat(Float(self.completedStudy.count) / Float(studyGoal))
        }
        
   
        
        
        
        if completedAmuseTrigger > 1 {
            completedAmuseTrigger = 1
        }
        if completedExercizeTrigger > 1 {
            completedExercizeTrigger = 1
        }
        if completedHealthTrigger > 1 {
            completedHealthTrigger = 1
        }
        if completedStudyTrigger > 1 {
            completedStudyTrigger = 1
        }

        
        self.animation.completedblue =  0.0
        self.animation.completedred =  0.0
        self.animation.completedgreen =  0.0
        self.animation.completedyellow =  0.0
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func fireTimer() {
        print("Timer fired!")
        
        
        if(index<1){
            print(index)
            index = index+0.005
            //index = index+self.movement_tick
            //index = counter_timer*movement_tick
            
            if (index <= self.completedStudyTrigger ){
                self.animation.completedgreen =  index

            }
            if (index <= self.completedAmuseTrigger){
                self.animation.completedblue =  index

            }
            if (index <= self.completedHealthTrigger){
                self.animation.completedyellow =  index

            }
            if (index <= self.completedExercizeTrigger){
                self.animation.completedred =  index

            }
            
        }
        else if index == 1{
            
            let myColor : MyCustomColors = MyCustomColors()
            
            
            timer!.invalidate()
            
        }
        else{
            print(index)
            index = index+1
            timer!.invalidate()
            print("Timer Stop")
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

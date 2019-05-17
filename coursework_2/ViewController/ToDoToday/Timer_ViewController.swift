//
//  Timer_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 16/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class Timer_ViewController: UIViewController {

    var activityToBeExecuted:Activity?
    var dateOfActivity:Date?
    var animationValue : Int = 0
    var seconds:Int = 0
    @IBOutlet weak var label_timer: UILabel!
    
    @IBAction func start_button(_ sender: UIButton) {
         timer!.fire()
    }
    
    @IBOutlet weak var button_complete: RoundButtonDesignable!
    @IBAction func completeActivity(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Warning", message: "🐵 Have you really completed the activity? 🐵", preferredStyle: .alert)
        
        let complete = UIAlertAction(title: "Yes Sure!", style: .destructive, handler: { (action) in
            self.insertActivityInCoreDataCompleted()
            self.navigationController?.popToRootViewController(animated: true)

        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(complete)
        
        present(alertController, animated: true, completion: nil)

        
    }
    
    
    
    @IBOutlet weak var animation: TimerClock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let min = Int(activityToBeExecuted!.duration)
        
        seconds = min*60
        self.label_timer.text = "\(seconds)"

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button_complete.isHidden = true
        
        self.animation.prgress = 0.0
        moveTheAnimation()
    }
    var index : CGFloat = 0.0
    var timer : Timer?
    func moveTheAnimation(){
        
        movement_tick = 1/CGFloat(seconds)
        //activity_time_in_seconds = seconds
        //movement_tick_per_second = 1/activity_time_in_seconds
        //movement_tick = counter_time * movement_tick_per_second
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    var counter_timer : CGFloat = 0.0
    var movement_tick : CGFloat = 0.0
    
    // using the timer to re-draw
    @objc func fireTimer() {
        print("Timer fired!")
        counter_timer=counter_timer+1.0
        
        print(counter_timer)
        seconds = seconds-1
        
        if(index<1){
            //index = index+0.0166
            //index = index+self.movement_tick
            index = counter_timer*movement_tick
            print(index)
            
            if seconds > 60{
                let minutes = seconds/60
                let sec = seconds - (60*minutes)
                self.label_timer.text = "\(minutes) min : \(sec) sec"
            }
            else{
                self.label_timer.text = "\(seconds) sec"
                
            }
            
            
            self.animation.prgress = index
        }
        else if index == 1{
            self.button_complete.isHidden = false
            timer!.invalidate()

        }
        else{
            print(index)
            index = index+1
            timer!.invalidate()
            print("Timer Stop")
        }
    }
    
    
    
    
    func insertActivityInCoreDataCompleted(){
        print("completed Actvity")
        updateCoreData()
        self.button_complete.isEnabled = false
        
    }
    
    
    func updateCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // manage Update
        // create a new entity
        let entity = NSEntityDescription.entity(forEntityName: "CompletedActivity", in: context)
        let newElement = NSManagedObject(entity: entity!, insertInto: context)
        newElement.setValue(self.activityToBeExecuted!.name, forKey: "activity_name")
        newElement.setValue(self.dateOfActivity!, forKey: "date")
        newElement.setValue(self.activityToBeExecuted?.cateogry?.name!, forKey: "category")
        
        // saving a entity
        do {
            try context.save()
        }catch {print("failed save!")}
        
        
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

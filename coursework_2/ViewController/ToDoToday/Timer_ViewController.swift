//
//  Timer_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 16/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class Timer_ViewController: UIViewController {

    var activityToBeExecuted:Activity?
    var animationValue : Int = 0
    var seconds:Int = 0
    @IBOutlet weak var label_timer: UILabel!
    
    @IBAction func start_button(_ sender: UIButton) {
         timer!.fire()
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
        
        if seconds > 60{
            let minutes = seconds/60
            let sec = seconds - (60*minutes)
            self.label_timer.text = "\(minutes) min : \(sec) sec"
        }
        else{
            self.label_timer.text = "\(seconds) sec"

        }
        

        if(index<1){
            //index = index+0.0166
            //index = index+self.movement_tick
            index = counter_timer*movement_tick
            print(index)
            self.animation.prgress = index
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

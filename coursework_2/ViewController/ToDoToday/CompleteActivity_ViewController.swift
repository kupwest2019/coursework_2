//
//  CompleteActivity_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 16/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class CompleteActivity_ViewController: UIViewController {

    @IBOutlet weak var label_recurrency: UILabel!
    
    @IBOutlet weak var start_button: UIButton!
    @IBOutlet weak var label_partner: UILabel!
    
    @IBOutlet weak var label_timer: UILabel!
    var activityToBeExecuted : Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(activityToBeExecuted?.duration_choice == false){
            start_button.isEnabled = false
            label_timer.text = "not set"
        }
        else{
            let duration = activityToBeExecuted!.duration
            let duration_string : String = String(duration)
            label_timer.text = "\(duration_string) minutes"
        }
        
        

        
        if (activityToBeExecuted!.monthly){
            label_recurrency.text = "Monthly"

        }
        if(activityToBeExecuted!.daily){
            label_recurrency.text = "Daily"

        }
        if(activityToBeExecuted!.weekly){
            label_recurrency.text = "Weekly"
        }

        label_partner.text = "Not Provided YET"
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "next"){
            let passingArgument = segue.destination as? Timer_ViewController
            passingArgument?.activityToBeExecuted = self.activityToBeExecuted
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

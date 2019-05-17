//
//  ShowGoalDeail_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 17/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        let day_start = my_helper_dates.returnCalendarDayMonthYear(inputDate: edit_category!.startDate!)
            
        let numb : Int32 = self.edit_category!.goal
        let goal = String(numb)

        self.start_date.text = "\(day_start.year!) - \(day_start.month!) - \(day_start.day!)"
        self.label_categoryGoal.text = goal
        
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

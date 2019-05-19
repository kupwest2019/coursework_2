//
//  ActivityCounter_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 19/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class ActivityCounter_ViewController: UIViewController {

    @IBAction func nextDay(_ sender: UIButton) {
        dayCounter = dayCounter + 1
        updateCounter(dayCounter)
    }
    
    
    var activity : Activity?
    @IBAction func prevDay(_ sender: UIButton) {
        dayCounter = dayCounter - 1
        updateCounter(dayCounter)

    }
    
    
    let core_data : Core_Data_Interface = accessingCoreData()

    var today : Date?
    
    func updateCounter(_ counter : Int) {
        let newDay = Calendar.current.date(byAdding: .day, value: dayCounter, to: today!)
        
        let calanderDate = Calendar.current.dateComponents([.year, .month, .day], from: newDay!)
        self.date_end_label.text = "\(calanderDate.day!) - \(calanderDate.month!) - \(calanderDate.year!)"
        
        guard let start_date = activity?.start_date else {fatalError("Unexpected class type in allObjects")}
        
        let result = core_data.returnCompletedActivitiesTwoDates(start_date: start_date, end_date: newDay!)
        
        let date_from = helper_date.returnCalendarDayMonthYear(inputDate: start_date)
        
        self.date_from_label.text = "\(date_from.day!) - \(date_from.month!) - \(date_from.year!)"
        
        self.numbers_label.text = "\(result.count) times"
        
    
    }
    
    

    
    
    
    @IBOutlet weak var date_from_label: UILabel!
    
    @IBOutlet weak var numbers_label: UILabel!
    @IBOutlet weak var date_end_label: UILabel!
    
    let helper_date = DealWithDate()
    
    let myColor = MyCustomColors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav_bar : NavigationBarCustom = ChangeTextNavigationBarAttribute()
        self.navigationItem.titleView = nav_bar.textNavBarAttributes(color1: myColor.blue, text1: "ACTIVITIES", color2: UIColor.black, text2: "counter")
        // Do any additional setup after loading the view.
    }
    
    var dayCounter : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        today = Date()
        dayCounter = 0
        let calanderDate = Calendar.current.dateComponents([.year, .month, .day], from: today!)
        self.date_end_label.text = "\(calanderDate.year!) - \(calanderDate.month!) - \(calanderDate.day!)"
        updateCounter(0)
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

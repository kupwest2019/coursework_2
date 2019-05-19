//
//  MainCoaching_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 18/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}


class MainCoaching_ViewController: UIViewController {
    
    @IBOutlet weak var label_YourBodyMass: UILabel!
    let defaults = UserDefaults.standard

    @IBOutlet weak var label_personalBMI: UILabel!
    @IBOutlet weak var label_underweight_BMI: UILabel!
    
    @IBOutlet weak var label_BMI_distribution: UILabel!
    @IBOutlet weak var label_normalBMI: UILabel!
    
    @IBOutlet weak var label_overweightBMI: UILabel!
    @IBOutlet weak var label_goalCategory: UILabel!
    
    @IBOutlet weak var label_advice: UILabel!
    @IBOutlet weak var animation: ForElements!
    @IBOutlet weak var textField_Advice: UITextView!
    @IBOutlet weak var label_activitiesNumber: UILabel!
    
    
    
    var user_detail_weight : Float = 0.0
    var goal_exercize  : Int = 0
    var number_activities  : Int = 0
    var underweight_user_weight  : Float = 0.0
    var overweight_user_weight  : Float = 0.0
    
    
    func thinkAboutIt(){
        if (user_detail_weight <= underweight_user_weight){
            if (goal_exercize == 0 || number_activities == 0) {
                textField_Advice.text = "Please be aware that you have to gain weight. \nTry to not stress yourself too much with exercize"
            }
            else{
               
                textField_Advice.text = "Please be aware that you have to gain weight. \nYou might consider to eat more and do less exercize !"

            }
            
        }
        else if (user_detail_weight >= overweight_user_weight){
            if (goal_exercize == 0 || number_activities == 0) {
                textField_Advice.text = "Please be aware that you have to lose weight. \nI saw that your exercize schedule is not too intensive, please try to fix it adding some activities and goal!"

            }
            else{
                textField_Advice.text = "Keep going and try to do as much exercize you can!"

            }
        }
        else {
            if (goal_exercize == 0 || number_activities == 0) {
                textField_Advice.text = "Your weight is perfect! \nYou might consider to set up goal and activities to keep track of it"

            }
            else{
                textField_Advice.text = "Yeah! keep going with your activities. \nYou are doing great!"
            }
            
        }
        
    }
    
    
    
    func populateInformationBMI(){
        print("NEW CHECK")
        if defaults.string(forKey: "Name") != nil{
            let user_weight = defaults.string(forKey: "Weight") as String?
            let user_height = defaults.string(forKey: "Heigh") as String?
            if let weight : Float = Float(user_weight!){
                user_detail_weight = weight
                if let height : Float = Float(user_height!){
                    let user_weight_string = String(format: "%.\(0)f", weight)

                    print(weight)
                    print(height)
                    
                    let cm_height = height/100
                    let cm_weight = weight
           
                    let underweightBMI : Float = 18.5
                    let normalBMI : Float = 22.5
                    let overweightBMI : Float = 25
                    
                    let bmi_user = cm_weight/(cm_height * cm_height)
                    underweight_user_weight = (underweightBMI * (cm_height * cm_height))
                    let normal_user = (normalBMI * (cm_height * cm_height))
                    overweight_user_weight = (overweightBMI * (cm_height * cm_height))
                    
                    let user_overweight = String(format: "%.\(0)f", overweight_user_weight)
                    let user_lightweight = String(format: "%.\(0)f", underweight_user_weight)

                    let normal_user_low = String(format: "%.\(0)f", normal_user-3)
                    let normal_user_high = String(format: "%.\(0)f", normal_user+3)
                    self.label_BMI_distribution.text = ""
                    label_personalBMI.text = "\(bmi_user)"
                    print(bmi_user.clean)
                    
                    label_underweight_BMI.text = "don't go under \(user_lightweight) kg, you will be under weight!"
                    label_normalBMI.text = "try to stay between \(normal_user_low) - \(normal_user_high) kg!"
                    label_overweightBMI.text =  "do not exceed \(user_overweight) kg!"
                    
                    
                    
                    label_YourBodyMass.text = "The BMI for your weight ( \(user_weight_string) kg ) is..."
                    
                    label_personalBMI.isHidden = false
                    self.label_underweight_BMI.isHidden = false
                    self.label_overweightBMI.isHidden = false
                    self.label_normalBMI.isHidden = false
                    self.label_goalCategory.isHidden = false
                    self.label_activitiesNumber.isHidden = false
                    self.animation.isHidden = false
                    self.textField_Advice.isHidden = false
                    self.label_BMI_distribution.isHidden = false
                    label_activitiesNumber.isHidden = false
                    label_goalCategory.isHidden = false
                    
                    
                    
                    
                }
            }
            
          
        }
        else{
            label_YourBodyMass.text = "Please complete personal information"
            label_personalBMI.isHidden = true
            self.label_advice.isHidden = true
            self.label_underweight_BMI.isHidden = true
            self.label_overweightBMI.isHidden = true
            self.label_normalBMI.isHidden = true
            self.label_goalCategory.isHidden = true
            self.label_activitiesNumber.isHidden = true
            self.animation.isHidden = true
            self.textField_Advice.isHidden = true
            self.label_BMI_distribution.isHidden = true
            self.label_advice.isHidden = true
            label_activitiesNumber.isHidden = true
            label_goalCategory.isHidden = true
            
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // **** editing bar style //
        
        let nav = self.navigationController?.navigationBar
        
        // 2
        let myColor = MyCustomColors()
       // nav?.barStyle = UIBarStyle.blackOpaque
        nav?.backgroundColor = myColor.light_orange
        nav?.tintColor = myColor.blue
        
        // 3
        
        let nav_bar : NavigationBarCustom = ChangeTextNavigationBarAttribute()
        self.navigationItem.titleView = nav_bar.textNavBarAttributes(color1: UIColor.black, text1: "COACHING", color2: UIColor(rgb: 0x076037, alphaVal: 1.0), text2: "tips")
        
        //
        
        
        populateInformationBMI()
        populateExerciseGoal()
        thinkAboutIt()
        
       
        
        print("hello did appear")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("hello")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func populateExerciseGoal(){
        goal_exercize = 0
        number_activities = 0

        let core_data = accessingCoreData()
        let helper_date = DealWithDate()
        let today = Date()
        let ininite_date = helper_date.returnInfiniteDate()
        
        let activities_scheduled = core_data.return_To_Do_Activities_TwoDates(start_date: today, end_date: ininite_date)
        let predifined_category = PredifinedCategory()
        for activities in activities_scheduled{
            guard let category : Category = activities.cateogry else {fatalError("Unexpected class type in allObjects")}
            if category.name == predifined_category.exercise{
                number_activities = number_activities+1
            }
            
        }
        
        let categories = core_data.returnAllCategry()
        for category in categories{
            guard let name : String = category.name else {fatalError("Unexpected class type in allObjects")}
            if name == predifined_category.exercise{
                let goal = Int(category.goal)
                goal_exercize = goal
            }
        }
        
        
        label_activitiesNumber.text = "You have \(number_activities) exercize scheduled"
        label_goalCategory.text = "You have a goal of \(goal_exercize) exercize"
        
        
        
        
        
        
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

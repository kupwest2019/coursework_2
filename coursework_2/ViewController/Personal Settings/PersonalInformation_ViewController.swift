//
//  PersonalInformation_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 16/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class PersonalInformation_ViewController: UIViewController {

    let defaults = UserDefaults.standard

    
    
    @IBOutlet weak var lastname_label: UITextField!
    @IBOutlet weak var name_label: UITextField!
    @IBOutlet weak var weight_label: UITextField!
    @IBOutlet weak var age_label: UITextField!
    @IBOutlet weak var heigh_label: UITextField!
    
    @IBAction func save_button_trigger(_ sender: UIBarButtonItem) {
        if (lastname_label.text == "" || name_label.text == "" || weight_label.text == "" || age_label.text == "" || heigh_label.text == ""){
            
            let alertController = UIAlertController(title: "Warning", message: "Please complete all the information before save", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: "Warning", message: "Detail Saved in User Default 🤖", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK =)", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        
            defaults.set(name_label.text, forKey: "Name")
            defaults.set(lastname_label.text, forKey: "LastName")
            defaults.set(age_label.text, forKey: "Age")
            defaults.set(weight_label.text, forKey: "Weight")
            defaults.set(heigh_label.text, forKey: "Heigh")
        }
        
    }
    
    
    @IBOutlet weak var save_button: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func updateByUserDefault(){
        self.name_label.text = defaults.string(forKey: "Name")
        self.lastname_label.text = defaults.string(forKey: "LastName")
        self.age_label.text = defaults.string(forKey: "Age")
        self.weight_label.text = defaults.string(forKey: "Weight")
        self.heigh_label.text = defaults.string(forKey: "Heigh")

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let myColor = MyCustomColors()

        let nav_bar : NavigationBarCustom = ChangeTextNavigationBarAttribute()
        self.navigationItem.titleView = nav_bar.textNavBarAttributes(color1: myColor.orange, text1: "FEEDBACK", color2: UIColor.black, text2: "forUs")
        
        updateByUserDefault()
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

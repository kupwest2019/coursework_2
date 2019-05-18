//
//  MainSettings_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 18/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class MainSettings_ViewController: UIViewController {
    let defaults = UserDefaults.standard

    
    
   
    
    
    @IBAction func logOut(_ sender: UIButton) {
    
        let core_data = accessingCoreData()
        core_data.deleteAll()
        
        self.defaults.set("false", forKey: "LoggedIn")
        self.defaults.removeObject(forKey: "Name")
        self.defaults.removeObject(forKey: "LastName")
        self.defaults.removeObject(forKey: "Weight")
        self.defaults.removeObject(forKey: "Heigh")
        self.defaults.removeObject(forKey: "Age")
        self.defaults.set("false", forKey: "Category_uploaded")
        
     
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

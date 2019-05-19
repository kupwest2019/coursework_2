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

    // delete core data and user default
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
        
        let nav = self.navigationController?.navigationBar
        
        // 2
        let myColor = MyCustomColors()
        // nav?.barStyle = UIBarStyle.blackOpaque
        nav?.backgroundColor = myColor.blue
        nav?.tintColor = myColor.orange
        
        // 3
        
        let nav_bar : NavigationBarCustom = ChangeTextNavigationBarAttribute()
        self.navigationItem.titleView = nav_bar.textNavBarAttributes(color1: myColor.red, text1: "SETTINGS", color2: myColor.orange, text2: "")
        
        

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

//
//  ViewDetailTracker_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class ViewDetailTracker_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
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
    
    
    
    
    
   
    
    @IBOutlet weak var tabView: UITableView!
    
    @IBOutlet weak var animation: Stopwatch!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animation.prgress = 0.0
        moveTheAnimation()
    }
    var index : CGFloat = 0.0
    
    
    
    var timer : Timer?
    
    
    
    func moveTheAnimation(){
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        timer!.fire()
        
        
        
        
    }

    
    // using the timer to re-draw
    @objc func fireTimer() {
        print("Timer fired!")

        if(index<1){
            index = index+0.001
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
    
    var selectedDAyInfo : Calendar_Day_Activity?
    var activities : [Activity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedDAyInfo)
        activities = selectedDAyInfo!.activities_scheduled
        
        
        self.registerCustomCell()

        
        self.tabView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tabView.dataSource = self
        
    
        // Do any additional setup after loading the view.
    }
    

    func registerCustomCell(){
        let textFieldCell = UINib(nibName: "CustomCellTabView", bundle: nil)
        self.tabView.register(textFieldCell, forCellReuseIdentifier: "CustomCellTabView")
    }

}

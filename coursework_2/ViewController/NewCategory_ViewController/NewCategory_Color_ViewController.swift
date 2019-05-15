//
//  NewCategory_Color_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 14/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit

class NewCategory_Color_ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

   // used for passing values
    var new_category: Category_obj = Category_obj()
    var new_activity : Activity_obj?

    let colors = ["Red","Yellow","Green","Blue"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
    
    @IBOutlet weak var picker_colours: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker_colours.delegate = self
        picker_colours.dataSource = self
        print(new_category.name)
        
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "segue_CategoryColour"){
            let choosenColor = colors[picker_colours.selectedRow(inComponent: 0)]
            let passingArgument = segue.destination as? NewCategory_Goal_ViewController
            
            new_category.color = choosenColor
            
            passingArgument?.new_category = new_category
            passingArgument?.new_activity = new_activity

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

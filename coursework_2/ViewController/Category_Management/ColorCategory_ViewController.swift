//
//  ColorCategory_ViewController.swift
//  coursework_2
//
//  Created by Tiziano on 15/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import UIKit
import CoreData

class ColorCategory_ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var picker_colours: UIPickerView!
    
    var edit_category:Category?
    var editingRequest: Bool = false
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker_colours.delegate = self
        picker_colours.dataSource = self
        print(new_category.name)
        
        if editingRequest{
            let index = colors.firstIndex(of: self.edit_category!.colour!)

            self.picker_colours.selectRow(index!, inComponent: 0, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "segue_CategoryColour"){
            let choosenColor = colors[picker_colours.selectedRow(inComponent: 0)]
            let passingArgument = segue.destination as? GoalCategory_ViewController
            
            new_category.color = choosenColor
            
            passingArgument?.new_category = new_category
            passingArgument?.editingRequest = self.editingRequest
            if(editingRequest){
                passingArgument?.edit_category = self.edit_category!
            }
            
        }
        
        if(segue.identifier == "back"){
            editingRequest = false
            
        }
    }

}

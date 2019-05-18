//
//  CustomNavBarText.swift
//  coursework_2
//
//  Created by Tiziano on 18/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import Foundation
import UIKit


/*
 Class for Customize the Navigation Bar
 The protocol just define the method to create a title composed by 2 possible elements, with different possile color
 */


protocol NavigationBarCustom {
    func textNavBarAttributes(color1: UIColor, text1: String, color2: UIColor, text2: String) -> UILabel
}


class ChangeTextNavigationBarAttribute : NavigationBarCustom{
    func textNavBarAttributes(color1: UIColor, text1: String, color2: UIColor, text2: String) -> UILabel {
        
        
        /*
         Usage of MutableAttributetring to define new attributes for the string..
         in this case I defined a DEFAULT pattern Light + Medium
         */
        
        let navigationBarLabel = UILabel()
        let naviagationBarTitle = NSMutableAttributedString(string: text1, attributes: [NSAttributedString.Key.foregroundColor: color1, NSAttributedString.Key.font: UIFont.systemFont(ofSize: GeneralValues.sizeNavigationBar, weight: GeneralValues.weightNavigationBarLight)])
        
        naviagationBarTitle.append(NSMutableAttributedString(string: text2, attributes: [NSAttributedString.Key.foregroundColor: color2, NSAttributedString.Key.font: UIFont.systemFont(ofSize: GeneralValues.sizeNavigationBar, weight: GeneralValues.weightNavigationBarMedium)]))
        
        
        navigationBarLabel.attributedText = naviagationBarTitle
        
        return navigationBarLabel
        
        
    }
    
}


struct GeneralValues {
    // --------- TO MANAGE THE SCROLLVIEW WITH THE CUSTOM KEYBOARD ... INCREASE THE VALUE AND GO BIG !!
    static let increaseSizeVerificationKeyboardOffset : CGFloat = 45
    // ---------
    
    // -------- ATTRIBUTES NAVIGATION BAR TITLE --------/
    
    static let weightNavigationBarLight = UIFont.Weight.light
    static let sizeNavigationBar : CGFloat = 17.0
    static let weightNavigationBarMedium = UIFont.Weight.bold
}

//
//  Header_Images.swift
//  coursework_2
//
//  Created by Tiziano on 18/05/2019.
//  Copyright © 2019 group_a. All rights reserved.
//

import Foundation
import UIKit


/*
 
 extension of the UIViewController to clear the navigation bar and retrieve the size of the header
 
 */

extension UIViewController {
    func clearAndsetHeaderSize () -> CGFloat{
        
        var headerSize : CGFloat = 0
        
        if let navController = navigationController{
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            
            headerSize = CGFloat(retrieveSizeHeader())
            
            
            
        }
        return headerSize
        
        
    }
    
    func retrieveSizeHeader() -> Int{
        var sizePhoneScreen : Int = 0
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            //            print("iPhone 5 or 5S or 5C/ SE")
            sizePhoneScreen = PhoneHeaderSize.iPhone_5_5S_SE
        case 1334:
            //            print("iPhone 6/6S/7/8")
            sizePhoneScreen = PhoneHeaderSize.iPhone_6_6S_7_8
        case 1920, 2208:
            //            print("iPhone 6+/6S+/7+/8+")
            sizePhoneScreen = PhoneHeaderSize.iPhone_6p_6Sp_7p_8p
        case 2436:
            //            print("iPhone X, XS")
            sizePhoneScreen = PhoneHeaderSize.iPhone_X_XS
        case 2688:
            //            print("iPhone XS Max")
            sizePhoneScreen = PhoneHeaderSize.iPhone_XS_Max
        case 1792:
            //            print("iPhone XR")
            sizePhoneScreen = PhoneHeaderSize.iPhone_XR
        default:
            print("Unknown --> ERROR DETECTION PHONE !!")
        }
        return sizePhoneScreen
    }
}


struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        
        
        // text
        //  navBar.titleTextAttributes = attrs
        
        // ICON
        ///  navBar.tintColor = UIColor.red
    }
}


struct PhoneHeaderSize {
    static let iPhone_5_5S_SE = 59
    static let iPhone_6_6S_7_8 = 62
    static let iPhone_6p_6Sp_7p_8p = 62
    
    static let iPhone_X_XS = 87
    static let iPhone_XS_Max = 87
    static let iPhone_XR = 87
}

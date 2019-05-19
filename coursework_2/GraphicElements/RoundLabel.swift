//
//  RoundLabel.swift
//  coursework_2
//
//  Copyright © 2019 group_a. All rights reserved.
//

import Foundation
import UIKit

class RoundLabel: UILabel {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

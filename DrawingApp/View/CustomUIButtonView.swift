//
//  CustomUIButtonView.swift
//  DrawingApp
//
//  Created by Mac on 16/04/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

class CustomUIButtonView: UIButton {
    override func awakeFromNib() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 5
        layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        layer.borderWidth = 1
    }
}

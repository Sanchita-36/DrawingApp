//
//  LineAndColor.swift
//  DrawingApp
//
//  Created by Mac on 16/04/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

struct LineAndColorTouch {
    var color: UIColor? //color for the line(drawing)
    var points: [CGPoint]? //array of points will make a concreate line structure as we draw
    var width: CGFloat? //to decide size(thickness) for the line

    init(color: UIColor, points: [CGPoint]) {
        self.color = color
        self.points = points
    }
}



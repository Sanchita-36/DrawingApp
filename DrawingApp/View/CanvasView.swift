//
//  CanvasView.swift
//  DrawingApp
//
//  Created by Mac on 16/04/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    override func awakeFromNib() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 1
    }
    
    var lines = [LineAndColorTouch]()
    var strokeWidth: CGFloat = 1.0 // default value
    var strokeColor: UIColor = .black // default value
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        lines.forEach { (pointsInLine) in
            for(i, p) in (pointsInLine.points?.enumerated())! {
                if i == 0 {
                    context.move(to: p)
                }else {
                    context.addLine(to: p)
                }
                context.setStrokeColor(pointsInLine.color?.withAlphaComponent(pointsInLine.width ?? 1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(pointsInLine.width ?? 1.0)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(LineAndColorTouch(color: UIColor(), points: [CGPoint]()))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: nil) else {return}
        
        guard var lastPoint = lines.popLast() else {return}
        lastPoint.points?.append(touch)
        lastPoint.color = strokeColor
        lastPoint.width = strokeWidth
        lines.append(lastPoint)
        setNeedsDisplay()
    }
    
    func clearCanvasView() {
        lines.removeAll()
        setNeedsDisplay()
    }
}


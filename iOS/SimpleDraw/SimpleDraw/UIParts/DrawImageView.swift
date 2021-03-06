//
//  drawImageView.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/04.
//  Copyright © 2017年 Mame. All rights reserved.
//

import UIKit

// タッチで描画するView
class DrawImageView: UIImageView {
    
    var lastPoint: CGPoint!
    var bezier: UIBezierPath!
    var currentColor: UIColor?
    var currentThickness: CGFloat = 3.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first!.location(in: self)
        bezier = UIBezierPath()
        bezier.lineCapStyle = CGLineCap.round
        bezier.lineJoinStyle = .round
        bezier.move(to: lastPoint)
        DrawModeManager.shared.alreadyTouch = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first!.location(in: self)
        bezier.addLine(to: lastPoint)
        drawLine()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // ベジェ曲線の描画
    private func drawLine() {
        guard let color = currentColor else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        self.image?.draw(at: CGPoint(x: 0, y: 0))
        color.setStroke()
        bezier.lineWidth = currentThickness
        if DrawModeManager.shared.DrawMode == .Eraser {
            bezier.stroke(with: .clear, alpha: 0)
        } else {
            bezier.stroke()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.image = image
        UIGraphicsEndImageContext()
    }
}

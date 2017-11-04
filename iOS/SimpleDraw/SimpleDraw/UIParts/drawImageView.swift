//
//  drawImageView.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/04.
//  Copyright © 2017年 Mame. All rights reserved.
//

import UIKit

class drawImageView: UIImageView {
    
    var lastPoint: CGPoint!
    var bezier: UIBezierPath!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first!.location(in: self)
        bezier = UIBezierPath()
        bezier.lineCapStyle = CGLineCap.round
        bezier.move(to: lastPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first!.location(in: self)
        bezier.addLine(to: lastPoint)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    private func drawLine() {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        self.image?.draw(at: CGPoint(x: 0, y: 0))
        UIColor.red.setStroke()
        bezier.lineWidth = 3
        bezier.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.image = image
        UIGraphicsEndImageContext()
    }
}

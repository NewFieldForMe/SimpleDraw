//
//  UIColorExtension.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/04.
//  Copyright © 2017年 Mame. All rights reserved.
//

import UIKit

extension UIColor {
    class func RGB(R: Int, G: Int, B: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(R) / 255.0, green: CGFloat(G) / 255.0, blue: CGFloat(B) / 255.0, alpha: alpha)
    }
}

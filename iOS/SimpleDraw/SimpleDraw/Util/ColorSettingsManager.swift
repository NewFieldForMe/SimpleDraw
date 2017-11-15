//
//  ColorSettings.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/04.
//  Copyright © 2017年 Mame. All rights reserved.
//

import Foundation
import UIKit

// 色選択を行うシングルトンクラス
class ColorSettingsManager {
    static let shared = ColorSettingsManager()
    var Colors: Array<UIColor> = Array()
    
    private init() {
        Colors.append(UIColor.RGB(R: 0, G: 0, B: 0, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 255, G: 255, B: 255, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 230, G: 0, B: 18, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 243, G: 152, B: 0, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 255, G: 251, B: 0, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 143, G: 195, B: 31, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 0, G: 153, B: 68, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 0, G: 158, B: 150, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 0, G: 160, B: 233, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 0, G: 104, B: 183, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 29, G: 32, B: 136, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 146, G: 7, B: 131, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 228, G: 0, B: 127, alpha: 1.0))
        Colors.append(UIColor.RGB(R: 229, G: 0, B: 79, alpha: 1.0))
    }
}

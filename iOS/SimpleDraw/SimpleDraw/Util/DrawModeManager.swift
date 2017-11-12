//
//  DrawModeManager.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/05.
//  Copyright © 2017年 Mame. All rights reserved.
//

import Foundation

class DrawModeManager {
    enum DrawModeEnum: Int {
        case ColorSelect = 0
        case ThicknessSelect = 1
        case Eraser = 2
        case AllErase = 3
        case CartoonSelect = 4
    }
    var DrawMode: DrawModeEnum
    var alreadyTouch: Bool = false
    
    static let shared = DrawModeManager()
    private init() {
        DrawMode = DrawModeEnum.ColorSelect
    }
}

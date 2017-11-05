//
//  DrawModeManager.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/05.
//  Copyright © 2017年 Mame. All rights reserved.
//

import Foundation

class DrawModeManager {
    enum DrawModeEnum {
        case ColorSelect
        case ThicknessSelect
        case Eraser
        case AllErase
    }
    
    var DrawMode: DrawModeEnum
    
    static let shared = DrawModeManager()
    private init() {
        DrawMode = DrawModeEnum.ColorSelect
    }
}

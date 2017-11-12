//
//  CartoonManager.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/12.
//  Copyright © 2017年 Mame. All rights reserved.
//

import Foundation
import UIKit

class CartoonManager {
    static let shared = CartoonManager()
    var cartoonImages: [UIImage] = []
    private init() {
        cartoonImages.append(UIImage(named: "cow")!)
        cartoonImages.append(UIImage(named: "horse")!)
        cartoonImages.append(UIImage(named: "mouse")!)
        cartoonImages.append(UIImage(named: "pig")!)
    }
}

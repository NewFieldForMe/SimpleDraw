//
//  CartoonManager.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/12.
//  Copyright © 2017年 Mame. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SwiftyJSON

class CartoonManager {
    static let shared = CartoonManager()
    var cartoonImages: [UIImage] = []
    private init() {
    }
    func getCartoonList() -> Observable<JSON>{
        return APIManager.shared.getCartoonListAPI().flatMap({ (json) -> Observable<JSON> in
            self.cartoonImages.removeAll()
            for object in json["cartoon_list"].arrayValue {
                self.cartoonImages.append(UIImage(named: object["name"].string!)!)
            }
            return Observable.just(json)
        })
    }
}

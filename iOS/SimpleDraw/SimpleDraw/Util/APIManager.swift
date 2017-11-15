//
//  APIManager.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/13.
//  Copyright © 2017年 Mame. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

// APIコールを司るシングルトンクラス
class APIManager {
    static let shared = APIManager()
    let apiBase = "https://simpledraw-apis.herokuapp.com/api/"
    let cartoonlistURL = "cartoonlist"

    private init() {
    }
    
    // 汎用的なAPIコールメソッド
    private func request(url: String) -> Observable<JSON> {
        return Observable.create { (observer: AnyObserver<JSON>) in
            Alamofire.request(url).validate().responseJSON() { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    observer.onNext(json)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    // 下絵リストのAPIをコールする
    func getCartoonListAPI() -> Observable<JSON> {
        return request(url: apiBase + cartoonlistURL)
    }
}

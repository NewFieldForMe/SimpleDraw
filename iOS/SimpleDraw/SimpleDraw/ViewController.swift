//
//  ViewController.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/03.
//  Copyright © 2017年 Mame. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

@available(iOS 11.0, *)
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate {
    
    @IBOutlet weak var drawSelectorCollectionView: UICollectionView!
    @IBOutlet weak var drawImageView: DrawImageView!
    @IBOutlet weak var catoonImageView: UIImageView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib: UINib = UINib(nibName: "DrawSelectorCollectionViewCell", bundle: nil)
        drawSelectorCollectionView.register(nib, forCellWithReuseIdentifier: "DrawSelectorCollectionViewCell")
        
        self.drawSelectorCollectionView.dataSource = self
        self.drawSelectorCollectionView.delegate = self;
        
        drawSelectorCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "transparent")!)
        drawImageView.currentColor = ColorSettingsManager.shared.Colors[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawSelectorCollectionViewCell", for: indexPath) as? DrawSelectorCollectionViewCell
        
        cell?.layoutSetup()

        if indexPath.section == 0 {
            switch indexPath.item {
            case 0:
                cell?.settingSetup(settingMode: DrawModeManager.DrawModeEnum.ColorSelect)
            case 1:
                cell?.settingSetup(settingMode: DrawModeManager.DrawModeEnum.ThicknessSelect)
            case 2:
                cell?.settingSetup(settingMode: DrawModeManager.DrawModeEnum.Eraser)
            case 3:
                cell?.settingSetup(settingMode: DrawModeManager.DrawModeEnum.AllErase)
            case 4:
                cell?.settingSetup(settingMode: DrawModeManager.DrawModeEnum.CartoonSelect)
            default:
                print("error")
            }
        } else if indexPath.section == 1 {
            switch DrawModeManager.shared.DrawMode {
            case .ColorSelect:
                cell?.colorSetup(color: ColorSettingsManager.shared.Colors[indexPath.item])
            case .ThicknessSelect:
                cell?.thicknessSetup(thickness: CGFloat(indexPath.item + 1) * 3.0)
            case .CartoonSelect:
                cell?.cartoonSetup(index: indexPath.item)
            default: break
            }
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 5
        case 1:
            switch DrawModeManager.shared.DrawMode {
            case .ColorSelect:
                return 14
            case .Eraser:
                return 0
            case .ThicknessSelect:
                return 10
            case .AllErase:
                return 0
            case .CartoonSelect:
                return CartoonManager.shared.cartoonImages.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.drawSelectorCollectionView.frame.height, height: self.drawSelectorCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            DrawModeManager.shared.DrawMode = DrawModeManager.DrawModeEnum(rawValue: indexPath.item)!
            drawSelectorCollectionView.reloadData()
            switch DrawModeManager.shared.DrawMode {
            case .AllErase:
                allEraseWithAlert(completion: nil)
                DrawModeManager.shared.DrawMode = .ColorSelect
            case .CartoonSelect:
                SVProgressHUD.setDefaultMaskType(.black)
                SVProgressHUD.show(withStatus: "通信中...")
                // 下絵のリストAPIを叩いて、JSON取得完了時にリストを作り直す
                CartoonManager.shared.getCartoonList().subscribe(
                    onNext: {(json) in
                        self.drawSelectorCollectionView.reloadData()
                        SVProgressHUD.dismiss()
                    },
                    onError: {(error) in
                        SVProgressHUD.dismiss()
                        print(error)
                        SVProgressHUD.showError(withStatus: "通信に失敗しました。")
                    },
                    onCompleted: {
                    }
                ).disposed(by: self.disposeBag)
            default: break
            }
        } else if indexPath.section == 1 {
            switch DrawModeManager.shared.DrawMode {
            case .ColorSelect:
                drawImageView.currentColor = ColorSettingsManager.shared.Colors[indexPath.item]
            case .ThicknessSelect:
                drawImageView.currentThickness = CGFloat(indexPath.item + 1) * 3.0
            case .CartoonSelect:
                allEraseWithAlert(completion: {
                    self.catoonImageView.image = CartoonManager.shared.cartoonImages[indexPath.item]
                })
            default: break
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // 全消去の確認アラートを表示して全消去を実行する
    private func allEraseWithAlert(completion: (()->Void)?) {
        if DrawModeManager.shared.alreadyTouch == true {
            let alert = UIAlertController(title: "確認", message: "全消去します。\nよろしいですか？", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
                self.allErase(completion: completion)
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        } else {
            allErase(completion: completion)
        }
    }
    
    // 全消去を行う
    private func allErase(completion: (()->Void)?) {
        UIView.transition(with: self.catoonImageView, duration: 1.0, options: [.transitionCurlUp], animations: {
            self.catoonImageView.isHidden = true
        }) { _ in
            self.catoonImageView.image = nil
            self.catoonImageView.isHidden = false
            self.drawSelectorCollectionView.reloadData()
        }
        
        UIView.transition(with: self.drawImageView, duration: 1.0, options: [.transitionCurlUp], animations: {
            self.drawImageView.isHidden = true
        }) { _ in
            self.drawImageView.image = nil
            self.drawImageView.isHidden = false
            self.drawSelectorCollectionView.reloadData()
            completion?()
        }
        DrawModeManager.shared.alreadyTouch = false
    }
}

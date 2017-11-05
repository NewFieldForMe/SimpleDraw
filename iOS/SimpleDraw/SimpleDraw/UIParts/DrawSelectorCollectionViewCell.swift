//
//  DrawSelectorCollectionViewCell.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/04.
//  Copyright © 2017年 Mame. All rights reserved.
//

import UIKit

class DrawSelectorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func layoutSetup() {
        imageView.layer.borderWidth = 3.0
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
    }
    
    func settingSetup(settingMode: DrawModeManager.DrawModeEnum) {
        imageView.image = nil
        imageView.backgroundColor = UIColor.white
        titleLabel.isHidden = false

        switch settingMode {
        case DrawModeManager.DrawModeEnum.ColorSelect:
            titleLabel.text = "色"
        case DrawModeManager.DrawModeEnum.ThicknessSelect:
            titleLabel.text = "太さ"
        case DrawModeManager.DrawModeEnum.Eraser:
            titleLabel.text = "消し\nゴム"
        case DrawModeManager.DrawModeEnum.AllErase:
            titleLabel.text = "全\n消去"
        default:
            titleLabel.isHidden = false
        }
    }
    
    func colorSetup(color: UIColor) {
        imageView.image = UIImage(named: "background1")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.tintColor = color
        titleLabel.isHidden = true
    }
    
    func thicknessSetup(thickness: CGFloat) {
        imageView.image = nil
        titleLabel.isHidden = true
    }
}

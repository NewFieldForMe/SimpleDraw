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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

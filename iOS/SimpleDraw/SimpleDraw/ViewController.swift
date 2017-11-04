//
//  ViewController.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/03.
//  Copyright © 2017年 Mame. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate {
    
    @IBOutlet weak var drawSelectorCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib: UINib = UINib(nibName: "DrawSelectorCollectionViewCell", bundle: nil)
        drawSelectorCollectionView.register(nib, forCellWithReuseIdentifier: "DrawSelectorCollectionViewCell")
        
        self.drawSelectorCollectionView.dataSource = self
        self.drawSelectorCollectionView.delegate = self;
        
        drawSelectorCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "transparent")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionView
    @available(iOS 11.0, *)
    @available(iOS 11.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawSelectorCollectionViewCell", for: indexPath) as? DrawSelectorCollectionViewCell
        cell?.imageView.image = UIImage(named: "background1")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        cell?.imageView.tintColor = ColorSettings.shared.Colors[indexPath.row]
        cell?.layoutSetup()
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.drawSelectorCollectionView.frame.height, height: self.drawSelectorCollectionView.frame.height)
    }
    
}

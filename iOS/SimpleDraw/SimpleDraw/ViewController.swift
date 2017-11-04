//
//  ViewController.swift
//  SimpleDraw
//
//  Created by 山田良 on 2017/11/03.
//  Copyright © 2017年 Mame. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var drawSelectorCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib: UINib = UINib(nibName: "DrawSelectorCollectionViewCell", bundle: nil)
        drawSelectorCollectionView.register(nib, forCellWithReuseIdentifier: "DrawSelectorCollectionViewCell")
        self.drawSelectorCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawSelectorCollectionViewCell", for: indexPath) as? DrawSelectorCollectionViewCell
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

}

//
//  ViewController.swift
//  MosaicLayout
//
//  Created by Allen on 16/2/1.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import FMMosaicLayout

class ViewController: UICollectionViewController {
    
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"]
        let mosaicLayout = FMMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        if #available(iOS 11.0, *) {
            self.collectionView?.contentInsetAdjustmentBehavior = .never
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.alpha = 0
        
        let imageView = cell.contentView.viewWithTag(2) as! UIImageView
        imageView.image = UIImage(named: imageArray[indexPath.row])
        
        let cellDelay = UInt64((arc4random() % 600 ) / 1000 )
        let cellDelayTime = DispatchTime(uptimeNanoseconds: cellDelay * NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: cellDelayTime) {
            UIView.animate(withDuration: 0.8, animations: {
                cell.alpha = 1.0
            })
        }
        
        return cell
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
}

extension ViewController : FMMosaicLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAt indexPath: IndexPath!) -> FMMosaicCellSize {
        return indexPath.item % 7 == 0 ? .big : .small
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
}

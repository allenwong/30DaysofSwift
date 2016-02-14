//
//  ViewController.swift
//  CollectionViewAnimation
//
//  Created by Allen on 16/1/26.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    @IBOutlet var testCollectionView: UICollectionView!
    
    var imageArray = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageArray = ["1", "2", "3", "4", "5"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private struct Storyboard {
        static let CellIdentifier = "TestCell"
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: imageArray[indexPath.row])
        
        let textView = cell.viewWithTag(2) as! UITextView
        textView.scrollEnabled = false
        
        let backButton = cell.viewWithTag(3) as! UIButton
        backButton.hidden = true
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.superview?.bringSubviewToFront(cell!)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: { () -> Void in
            
            cell?.frame = collectionView.bounds
            collectionView.scrollEnabled = false
            
            let textView = cell!.viewWithTag(2) as! UITextView
            textView.scrollEnabled = false
            
            let backButton = cell!.viewWithTag(3) as! UIButton
            backButton.hidden = false
            backButton.addTarget(self, action: Selector("backButtonDidTouch"), forControlEvents: UIControlEvents.TouchUpInside)
                        
            }, completion: nil)
        
    }
    
    func backButtonDidTouch() {
        
        let indexPath = self.collectionView!.indexPathsForSelectedItems() 
        collectionView?.scrollEnabled = true
        collectionView?.reloadItemsAtIndexPaths(indexPath!)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    

}


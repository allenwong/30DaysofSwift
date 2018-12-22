//
//  HomeViewController.swift
//  Carousel Effect
//
//  Created by Allen on 16/1/11.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUSerFullNameButton: UIButton!
    
    // 访问权限分物种：private，fileprivate，internal，public 和 open
    // private：只能在本类的作用域且在当前文件内能访问
    // fileprivate：只能在当前文件内能访问
    // internal：本module内能访问
    // public：跨module访问但不能重写或继承
    // open：跨module访问并且能重写或继承
    fileprivate var interests = Interest.createInterests()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    fileprivate struct Storyboard {
        static let CellIdentifier = "InterestCell"
        static let CellPadding: CGFloat = 20.0
    }
    

}

extension HomeViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! InterestCollectionViewCell
        
        cell.interest = self.interests[indexPath.item]
        
        return cell
        
    }
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 2 * Storyboard.CellPadding, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2 * Storyboard.CellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, Storyboard.CellPadding, 0, Storyboard.CellPadding)
    }
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let originPoint = targetContentOffset.pointee;
        var index = Int(originPoint.x / UIScreen.main.bounds.width)
        let offset = Int(originPoint.x) % Int(UIScreen.main.bounds.width)
        index += (offset > Int(UIScreen.main.bounds.width/2) ? 1 : 0)
        targetContentOffset.pointee = CGPoint(x: index * Int(UIScreen.main.bounds.width) , y: 0)
    }
}

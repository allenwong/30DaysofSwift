//
//  ViewController.swift
//  ImageScrollerEffect
//
//  Created by Allen on 16/1/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "steve"))
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize = imageView.bounds.size
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        
        scrollView.delegate = self
        setZoomScaleFor(scrollView.bounds.size)
        scrollView.zoomScale = scrollView.minimumZoomScale
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageView.center = view.center
        setZoomScaleFor(scrollView.bounds.size)
        
        if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
        //recenterImage()
    }
    
    fileprivate func setZoomScaleFor(_ srollViewSize: CGSize) {
        
        let imageSize = imageView.bounds.size
        let widthScale = srollViewSize.width / imageSize.width
        let heightScale = srollViewSize.height / imageSize.height
        let minimunScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minimunScale
        scrollView.maximumZoomScale = 3.0
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        recenterImage()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        recenterImage()
    }
    func recenterImage() {
        
        let scrollViewSize = scrollView.bounds.size
        var imageViewSize = imageView.frame
        
        let widthDiff = scrollViewSize.width - imageViewSize.size.width
        let heightDiff = scrollViewSize.height - imageViewSize.size.height
        imageViewSize.origin.x = (widthDiff  > 0) ? widthDiff  / 2 : 0
        imageViewSize.origin.y = (heightDiff > 0) ? heightDiff / 2 : 0
        imageView.frame = imageViewSize
        
    }

}


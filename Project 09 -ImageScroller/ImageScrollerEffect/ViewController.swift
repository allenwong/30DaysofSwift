//
//  ViewController.swift
//  ImageScrollerEffect
//
//  Created by 瞿炬星 on 2018/3/21.
//  Copyright © 2018年 瞿炬星. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    //计算scrollView的缩放比例，缩放比例为1表示内容以正常大小显示；缩放比例小于1表示容器内的内容缩小，缩放比例大于1表示放大容器内的内容
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize)
    {
        //要获得最小的缩放比例，首先计算所需的缩放比例，以便根据其宽度在scrollView中紧贴imageView
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        //选取宽度和高度比例中最小的那个,设置为minimumZoomScale
        let minScale = min(widthScale,heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    // //当scrollView的内容大小小于边界时，内容将放置在左上角而不是中心，updateConstraintForSize方法处理这个问题；通过调整图像视图的布局约束。
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
        
        ////将图像垂直居中，从视图高度减去imageView的高度并分成两半，这个值用作顶部和底部imageView的约束
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        ////根据宽度计算imageView前后约束的偏移量
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    //每次控制器更新其子视图时，更新最小缩放比例
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
       //当手势动作发生时，scrollView告诉控制器要放大或缩小子视图imageView
        return imageView
    }



}


//
//  ViewController.swift
//  PullRefresh
//
//  Created by Allen on 1/25/16.
//  Copyright (c) 2016 App Kitchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblDemo: UITableView!
    
    var refreshController: UIRefreshControl!
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var timer: Timer!
    var dataArray: Array<String> = ["😂", "🤗", "😳", "😌", "😊"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblDemo.delegate = self
        tblDemo.dataSource = self
        refreshController = UIRefreshControl()
        refreshController.backgroundColor = UIColor.clear
        refreshController.tintColor = UIColor.clear
        tblDemo.addSubview(refreshController)
        
        loadCustomRefreshContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        
        cell.textLabel!.text = dataArray[(indexPath as NSIndexPath).row]
        cell.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 40)
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func loadCustomRefreshContents() {
        
        let refreshContents = Bundle.main.loadNibNamed("RefreshContents", owner: self, options: nil)
        
        customView = refreshContents?[0] as! UIView
        customView.frame = refreshController.bounds
        
        for i in 0 ..< customView.subviews.count + 1 {
            
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
            
        }
        
        refreshController.addSubview(customView)
    }
    
    func animateRefreshStep1() {
        
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
            
            }, completion: { (finished) -> Void in
                
                UIView.animate(withDuration: 0.05, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                    self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform.identity
                    self.labelsArray[self.currentLabelIndex].textColor = UIColor.black
                    
                    }, completion: { (finished) -> Void in
                        self.currentLabelIndex += 1
                        
                        if self.currentLabelIndex < self.labelsArray.count {
                            self.animateRefreshStep1()
                        }
                        else {
                            self.animateRefreshStep2()
                        }
                })
        })
    }
    
    
    func animateRefreshStep2() {
        UIView.animate(withDuration: 0.40, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            
            self.labelsArray[0].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[1].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[2].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[3].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[4].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[5].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[6].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[7].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[8].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[9].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[10].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[11].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            }, completion: { (finished) -> Void in
            
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                    self.labelsArray[0].transform = CGAffineTransform.identity
                    self.labelsArray[1].transform = CGAffineTransform.identity
                    self.labelsArray[2].transform = CGAffineTransform.identity
                    self.labelsArray[3].transform = CGAffineTransform.identity
                    self.labelsArray[4].transform = CGAffineTransform.identity
                    self.labelsArray[5].transform = CGAffineTransform.identity
                    self.labelsArray[6].transform = CGAffineTransform.identity
                    self.labelsArray[7].transform = CGAffineTransform.identity
                    self.labelsArray[8].transform = CGAffineTransform.identity
                    self.labelsArray[9].transform = CGAffineTransform.identity
                    self.labelsArray[10].transform = CGAffineTransform.identity
                    self.labelsArray[11].transform = CGAffineTransform.identity
                    
                    }, completion: { (finished) -> Void in
                        if self.refreshController.isRefreshing {
                            self.currentLabelIndex = 0
                            self.animateRefreshStep1()
                        }
                        else {
                            self.isAnimating = false
                            self.currentLabelIndex = 0
                            for i in 0 ..< self.labelsArray.count + 1 {
                                self.labelsArray[i].textColor = UIColor.black
                                self.labelsArray[i].transform = CGAffineTransform.identity
                            }
                        }
                })
        })
    }
    
    func getNextColor() -> UIColor {
        var colorsArray: Array<UIColor> = [UIColor.magenta, UIColor.brown, UIColor.yellow, UIColor.red, UIColor.green, UIColor.blue, UIColor.orange]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex += 1
        
        return returnColor
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshController.isRefreshing {
            if !isAnimating {
                
                doSomething()
                animateRefreshStep1()
                
            }
        }
    }
    
    func doSomething() {
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ViewController.endedOfWork), userInfo: nil, repeats: true)
    }
    
    func endedOfWork() {
        
        refreshController.endRefreshing()
        timer.invalidate()
        timer = nil
    }

    

}


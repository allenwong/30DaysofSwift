//
//  ViewController.swift
//  EmojiMachine
//
//  Created by Allen on 16/1/19.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emojiPickerView: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var amazingFlag = false
    var bounds: CGRect = CGRect.zero
    
    // MARK:生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bounds = goButton.bounds
        imageArray = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
        
        for _ in 0...100 {
            self.dataArray1.append((Int)(arc4random() % 10 ))
            self.dataArray2.append((Int)(arc4random() % 10 ))
            self.dataArray3.append((Int)(arc4random() % 10 ))
        }
        
        resultLabel.text = ""
        
        emojiPickerView.delegate = self
        emojiPickerView.dataSource = self
        
        goButton.layer.cornerRadius = 6
        goButton.layer.masksToBounds = true
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        goButton.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            
            self.goButton.alpha = 1
            
            }, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:按钮事件
    @IBAction func amazingButtonDidTouch(_ sender: UIButton) {
        amazingFlag = !amazingFlag;
        sender.setTitle(amazingFlag ? "开挂模式":"常规模式", for: .normal)
    }
    @IBAction func goButtoDidTouch(_ sender: AnyObject) {
        let index1: Int
        let index2: Int
        let index3: Int
        if amazingFlag {
            index1 = Int(arc4random()) % 90 + 3
            index2 = dataArray2.firstIndex(of: dataArray1[index1])!
            index3 = dataArray3.lastIndex(of: dataArray1[index1])!
            
        } else {
            index1 = Int(arc4random()) % 90 + 3
            index2 = Int(arc4random()) % 90 + 3
            index3 = Int(arc4random()) % 90 + 3
        }
        
        emojiPickerView.selectRow(index1, inComponent: 0, animated: true)
        emojiPickerView.selectRow(index2, inComponent: 1, animated: true)
        emojiPickerView.selectRow(index3, inComponent: 2, animated: true)
        
        
        if(dataArray1[emojiPickerView.selectedRow(inComponent: 0)] == dataArray2[emojiPickerView.selectedRow(inComponent: 1)] && dataArray2[emojiPickerView.selectedRow(inComponent: 1)] == dataArray3[emojiPickerView.selectedRow(inComponent: 2)]) {
            
            resultLabel.text = "Bingo!"
            
        } else {
            
            resultLabel.text = "💔"
            
        }
        
        
        //animate
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: {
            
            self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width - 20, height: self.bounds.size.height)
            
        }, completion: { (compelete: Bool) in
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                
                self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
                
            }, completion: nil)
            
        })
        
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK:UIPickerViewDataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // MARK:UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        if component == 0 {
            pickerLabel.text = imageArray[(Int)(dataArray1[row])]
        } else if component == 1 {
            pickerLabel.text = imageArray[(Int)(dataArray2[row])]
        } else {
            pickerLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
}


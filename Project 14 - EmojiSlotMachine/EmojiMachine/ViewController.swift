//
//  ViewController.swift
//  EmojiMachine
//
//  Created by Allen on 16/1/19.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var emojiPickerView: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    @IBAction func goButtoDidTouch(_ sender: AnyObject) {
        
        emojiPickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 0, animated: true)
        emojiPickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 1, animated: true)
        emojiPickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 2, animated: true)
        
        
        if(dataArray1[emojiPickerView.selectedRow(inComponent: 0)] == dataArray2[emojiPickerView.selectedRow(inComponent: 1)] && dataArray2[emojiPickerView.selectedRow(inComponent: 1)] == dataArray3[emojiPickerView.selectedRow(inComponent: 2)]) {
            
            resultLabel.text = "Bingo!"
            
        } else {
            
            resultLabel.text = "💔"
            
        }
        
        
        //animate
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: {
            
            self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width + 20, height: self.bounds.size.height)
            
            }, completion: { (compelete: Bool) in
                
                UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                    
                    self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
                    
                    }, completion: nil)
                
        })
        
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var bounds: CGRect = CGRect.zero
    
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
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


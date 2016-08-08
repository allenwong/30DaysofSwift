//
//  ViewController.swift
//  LimitCharacters
//
//  Created by Allen on 16/1/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var bottomUIView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        
        tweetTextView.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.keyBoardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.keyBoardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let myTextViewString = tweetTextView.text
        characterCountLabel.text = "\(140 - (myTextViewString?.characters.count)!)"
        
        if range.length > 140{
            return false
        }
        
        let newLength = (myTextViewString?.characters.count)! + range.length
        
        return newLength < 140
        
        
        
    }
    
    func keyBoardWillShow(_ note:Notification) {
        
        let userInfo  = (note as NSNotification).userInfo
        let keyBoardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            
            self.bottomUIView.transform = CGAffineTransform(translationX: 0,y: -deltaY)
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else {
            
            animations()
        }
        
    }
    
    
    func keyBoardWillHide(_ note:Notification) {
        
        let userInfo  = (note as NSNotification).userInfo
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            
            self.bottomUIView.transform = CGAffineTransform.identity
            
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else{
            
            animations()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    

}


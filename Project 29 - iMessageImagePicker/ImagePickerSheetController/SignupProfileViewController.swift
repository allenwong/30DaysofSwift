//
//  SignupProfileViewController.swift
//  Interests
//
//  Created by _ on 6/20/15.
//  Copyright © 2015 Developers Academy. All rights reserved.
//

import UIKit
import Photos

class SignupProfileViewController: UIViewController
{

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    private var profileImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.becomeFirstResponder()
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.width / 2
        userProfileImageView.layer.masksToBounds = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    @IBAction func pickProfileImage(_ tap: UITapGestureRecognizer)
    {
        let authorization = PHPhotoLibrary.authorizationStatus()
        
        if authorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    self.pickProfileImage(tap)
                })
            })
        }
        
        if authorization == .authorized {
            let controller = ImagePickerSheetController()
            
            controller.addAction(ImageAction(title: NSLocalizedString("Take Photo or Video", comment: "Action Title"), secondaryTitle: NSLocalizedString("Use this one", comment: "Action Title"), handler: { (_) -> () in
                
                self.presentCamera()
                
                }, secondaryHandler: { (action, numberOfPhotos) -> () in
                    controller.getSelectedImagesWithCompletion({ (images) -> Void in
                        self.profileImage = images[0]
                        self.userProfileImageView.image = self.profileImage
                    })
            }))
            
            controller.addAction(ImageAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .cancel, handler: nil, secondaryHandler: nil))
            
            present(controller, animated: true, completion: nil)
        }
        
        
    }
    
    func presentCamera()
    {
        
    }


}













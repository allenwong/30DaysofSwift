//
//  AppDelegate.swift
//  3DTouchQuickAction
//
//  Created by Allen on 16/1/28.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum ShortcutIdentifier: String {
        
        case First
        case Second
        case Third
        
        init?(fullType: String) {
            guard let last = fullType.components(separatedBy: ".").last else {
                return nil
            }
            self.init(rawValue: last)
        }
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }

    }

    var window: UIWindow?
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
    // MARK:处理shortCutItem
    func handleShortCutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        var handled = false
        
        guard let _ = ShortcutIdentifier(fullType: shortcutItem.type) else {
            return false
        }
        
        guard let shortCutType = shortcutItem.type as String? else {
            return false
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            // Handle shortcut 1
            vc = storyboard.instantiateViewController(withIdentifier: "RunVC") as! RunViewController
            handled = true
        case ShortcutIdentifier.Second.type:
            // Handle shortcut 2
            vc = storyboard.instantiateViewController(withIdentifier: "ScanVC") as! ScanViewController
            handled = true
        case ShortcutIdentifier.Third.type:
            // Handle shortcut 3
            vc = storyboard.instantiateViewController(withIdentifier: "WiFiVC") as! SwitchWiFiViewController
            handled = true
        default:
            vc = UIViewController()
            break
        }
        
        // Display the selected view controller
        //
        var presentedVC: UIViewController = window!.rootViewController!
        while presentedVC.presentedViewController != nil {
            presentedVC = presentedVC.presentedViewController!
        }
        if !presentedVC.isMember(of: vc.classForCoder) {
            presentedVC.present(vc, animated: true, completion: nil)
        }
        
        return handled
    }
}


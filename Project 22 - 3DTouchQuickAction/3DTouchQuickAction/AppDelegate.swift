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
            guard let last = fullType.components(separatedBy: ".").last else { return nil }
            
            self.init(rawValue: last)
        }
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }

    }

    var window: UIWindow?
    
    var launchedShortcutItem: UIApplicationShortcutItem?

    
    func handleShortCutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        var handled = false
        
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = UIViewController()
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            // Handle shortcut 1
            vc = storyboard.instantiateViewController(withIdentifier: "RunVC") as! RunViewController
            handled = true
            break
        case ShortcutIdentifier.Second.type:
            // Handle shortcut 2
            vc = storyboard.instantiateViewController(withIdentifier: "ScanVC") as! ScanViewController
            handled = true
            break
        case ShortcutIdentifier.Third.type:
            // Handle shortcut 3
            vc = storyboard.instantiateViewController(withIdentifier: "WiFiVC") as! SwitchWiFiViewController
            handled = true
            break
        default:
            break
        }
        
        // Display the selected view controller
        window!.rootViewController?.present(vc, animated: true, completion: nil)
        
        return handled
        
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        guard let shortcut = launchedShortcutItem else { return }
        
        handleShortCutItem(shortcut)
        launchedShortcutItem = nil
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortcutItem
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


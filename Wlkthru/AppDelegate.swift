//
//  AppDelegate.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/22/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    let pageControl = UIPageControl.appearance()
    pageControl.pageIndicatorTintColor = UIColor.white
    pageControl.currentPageIndicatorTintColor = UIColor(red:0.95, green:0.25, blue:0.44, alpha:1.00)
    pageControl.backgroundColor = UIColor.clear
    
    UINavigationBar.appearance().barTintColor = UIColor(red: 0.95, green: 0.25, blue: 0.44, alpha: 1.00)
    UINavigationBar.appearance().tintColor = UIColor.white
    guard let validNavigationBarCustomFont = UIFont(name: "AvenirNext-Medium", size: 22.00) else { return }
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: validNavigationBarCustomFont]
  }
}


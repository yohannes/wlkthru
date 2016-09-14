//
//  ViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/22/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDataSource {
  
  // MARK: - Stored Properties
  
  let headerDescriptions = ["Capture Your Moment",
                            "Share Your Joy",
                            "Sync Your Life"]
  
  let subheaderDescriptions = ["Take pictures with incredible filters and control.",
                               "Connect with your friends. Sharing is caring.",
                               "Synchronize your data across iOS devices seamlessly."]
  
  let images = ["Photo1", "Photo2", "Photo3"]
  
  // MARK: - IBOutlet Properties
  
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var pageControl: UIPageControl!
  
  // MARK: - IBAction Methods
  
  @IBAction func registerButtonDidTouch(_ sender: UIButton) {
    
  }
  
  @IBAction func logInButtonDidTouch(_ sender: UIButton) {
    
  }
  
  // MARK: - UIPageViewControllerDataSource Methods
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let validPageContentViewController = viewController as? PageContentViewController else { return nil }
    var pageIndex = validPageContentViewController.pageIndex
    guard pageIndex > 0 else {
      self.pageControl.currentPage = 0
      return nil
    }
    self.pageControl.currentPage = pageIndex
    pageIndex = pageIndex - 1
    
    return self.viewControllerAtIndex(pageIndex)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let validPageContentViewController = viewController as? PageContentViewController else { return nil }
    var pageIndex = validPageContentViewController.pageIndex
    guard pageIndex < self.headerDescriptions.count - 1 else {
      self.pageControl.currentPage = self.headerDescriptions.count - 1
      return nil
    }
    self.pageControl.currentPage = pageIndex
    pageIndex = pageIndex + 1
    
    return self.viewControllerAtIndex(pageIndex)
  }
  
  // MARK: - UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let validStoryboard = self.storyboard, let validPageViewController = validStoryboard.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController else { return }
    
    validPageViewController.dataSource = self
    
    guard let validPageContentViewController = self.viewControllerAtIndex(0) else { return }
    
    validPageViewController.setViewControllers([validPageContentViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    
    validPageViewController.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    
    self.addChildViewController(validPageViewController)
    self.view.addSubview(validPageViewController.view)
    validPageViewController.didMove(toParentViewController: self)
    self.view.bringSubview(toFront: self.stackView)
    self.view.bringSubview(toFront: self.headerLabel)
  }
  
  // MARK - Helper Methods
  
  fileprivate func viewControllerAtIndex(_ index: Int) -> PageContentViewController? {
    guard index != NSNotFound || (index >= 0 && index < self.headerDescriptions.count) else { return nil }
    guard let validStoryboard = self.storyboard, let validPageContentViewController = validStoryboard.instantiateViewController(withIdentifier: "PageContentViewController") as? PageContentViewController else { return nil }
    
    validPageContentViewController.pageIndex = index
    validPageContentViewController.headerDescription = self.headerDescriptions[index]
    validPageContentViewController.subheaderDescription = self.subheaderDescriptions[index]
    validPageContentViewController.imageFile = self.images[index]
    
    return validPageContentViewController
    
  }
}


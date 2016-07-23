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
    
    @IBAction func registerButtonDidTouch(sender: UIButton) {
        
    }
    
    @IBAction func logInButtonDidTouch(sender: UIButton) {
        
    }
    
    // MARK: - UIPageViewControllerDataSource Methods
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
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
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
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
        
        guard let validStoryboard = self.storyboard, validPageViewController = validStoryboard.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController else { return }
        
        validPageViewController.dataSource = self
        
        guard let validPageContentViewController = self.viewControllerAtIndex(0) else { return }
        
        validPageViewController.setViewControllers([validPageContentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        validPageViewController.view.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)
        
        self.addChildViewController(validPageViewController)
        self.view.addSubview(validPageViewController.view)
        validPageViewController.didMoveToParentViewController(self)
        self.view.bringSubviewToFront(self.stackView)
        self.view.bringSubviewToFront(self.headerLabel)
    }
    
    // MARK - Helper Methods
    
    private func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        guard index != NSNotFound || (index >= 0 && index < self.headerDescriptions.count) else { return nil }
        guard let validStoryboard = self.storyboard, validPageContentViewController = validStoryboard.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController else { return nil }
        
        validPageContentViewController.pageIndex = index
        validPageContentViewController.headerDescription = self.headerDescriptions[index]
        validPageContentViewController.subheaderDescription = self.subheaderDescriptions[index]
        validPageContentViewController.imageFile = self.images[index]
        
        return validPageContentViewController
  
    }
}


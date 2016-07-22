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
    
    // MARK: - IBAction Methods
    
    @IBAction func registerButtonDidTouch(sender: UIButton) {
        
    }
    
    @IBAction func logInButtonDidTouch(sender: UIButton) {
        
    }
    
    // MARK: - UIPageViewControllerDataSource Methods
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let validPageContentViewController = viewController as? PageContentViewController else { return nil }
        var pageIndex = validPageContentViewController.pageIndex
        guard pageIndex > 0 else { return nil }
        pageIndex = pageIndex - 1
        
        return self.viewControllerAtIndex(pageIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let validPageContentViewController = viewController as? PageContentViewController else { return nil }
        var pageIndex = validPageContentViewController.pageIndex
        guard pageIndex < self.headerDescriptions.count - 1 else { return nil }
        pageIndex = pageIndex + 1
        
        return self.viewControllerAtIndex(pageIndex)
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let validStoryboard = self.storyboard, validPageContentViewController = validStoryboard.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController else { return 0 }
        return validPageContentViewController.pageIndex
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.headerDescriptions.count
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK - Helper Methods
    
    private func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        guard index != NSNotFound || (index >= 0 && index < self.headerDescriptions.count) else { return nil }
        guard let validStoryboard = self.storyboard, validPageContentViewController = validStoryboard.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController else { return nil }
        
        validPageContentViewController.headerLabel.text = self.headerDescriptions[index]
        validPageContentViewController.subheaderLabel.text = self.subheaderDescriptions[index]
        validPageContentViewController.imageFile = self.images[index]
        
        return validPageContentViewController
    }
}


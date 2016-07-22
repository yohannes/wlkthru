//
//  PageContentViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/22/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaderLabel: UILabel!
    
    // MARK: - Stored Properties
    
    var pageIndex = 0
    var headerDescription = ""
    var subheaderDescription = ""
    var imageFile = ""
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: imageFile)
        headerLabel.text = headerDescription
        subheaderLabel.text = subheaderDescription
    }

}

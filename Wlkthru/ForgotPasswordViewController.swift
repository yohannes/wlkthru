//
//  ForgotPasswordViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/27/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

// TODO: 2) once reset password button is pressed, display alert controller, and return to parent controller

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    var emailAddress = ""
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - IBAction Properties
    
    @IBAction func resetPasswordButtonDidTouch(sender: UIButton) {
        
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailLabel.text = self.emailAddress
    }
}

//
//  ForgotPasswordViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/27/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.becomeFirstResponder()
    }

}

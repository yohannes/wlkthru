//
//  ForgotPasswordViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/27/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    var emailAddress = ""
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - IBAction Properties
    
    @IBAction func resetPasswordButtonDidTouch(sender: UIButton) {
        let alertController = UIAlertController(title: "Request Sent", message: "Please check \(self.emailAddress) for verification link.", preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Default) { [unowned self] (_) in
            self.performSegueWithIdentifier("unwindToLoginViewController", sender: self)
        }
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailLabel.text = self.emailAddress
    }
}

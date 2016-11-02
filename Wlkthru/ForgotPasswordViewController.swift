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
  
  let resetEmailRequestAlertView: FCAlertView = {
    let alertView = FCAlertView(type: .success)
    alertView.colorScheme = UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1)
    return alertView
  }()
  
  // MARK: - IBOutlet Properties
  
  @IBOutlet weak var emailLabel: UILabel!
  
  // MARK: - IBAction Properties
  
  @IBAction func resetPasswordButtonDidTouch(_ sender: UIButton) {    
    self.resetEmailRequestAlertView.showAlert(inView: self,
                                              withTitle: "Request Sent",
                                              withSubtitle: "Please check \(self.emailAddress) for verification link.",
                                              withCustomImage: nil,
                                              withDoneButtonTitle: "UNDERSTOOD",
                                              andButtons: nil)
  }
  
  // MARK: - UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.emailLabel.text = self.emailAddress
    self.resetEmailRequestAlertView.delegate = self
  }
}

// MARK: - FCAlertViewDelegate Extension

extension ForgotPasswordViewController: FCAlertViewDelegate {
  func alertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {}
  func FCAlertDoneButtonClicked(alertView: FCAlertView) {
    self.performSegue(withIdentifier: "unwindToLoginViewController", sender: self)
  }
}

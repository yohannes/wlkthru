//
//  ForgotPasswordViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/27/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit
import SCLAlertView

class ForgotPasswordViewController: UIViewController {
  
  // MARK: - Stored Properties
  
  var emailAddress = ""
  var resetEmailRequestAlertView: SCLAlertView!
  
  // MARK: - IBOutlet Properties
  
  @IBOutlet weak var emailLabel: UILabel!
  
  // MARK: - IBAction Properties
  
  @IBAction func resetPasswordButtonDidTouch(_ sender: UIButton) {
    self.resetEmailRequestAlertView.showTitle("Request Sent",
                                              subTitle: "Please check \(self.emailAddress) for verification link.",
                                              style: SCLAlertViewStyle.success,
                                              colorStyle: 0x7AD8C0)
  }
  
  // MARK: - UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.emailLabel.text = self.emailAddress
    
    // self.resetEmailRequestAlertView.delegate = self
    
    self.resetEmailRequestAlertView = {
      let appearance = SCLAlertView.SCLAppearance(kTitleFont: UIFont(name: "AvenirNext-Bold", size: 20)!,
                                                  kTextFont: UIFont(name: "AvenirNext-Bold", size: 16)!,
                                                  kButtonFont: UIFont(name: "AvenirNext-Bold", size: 20)!,
                                                  showCloseButton: false,
                                                  contentViewColor: UIColor(red: 220/255, green: 1, blue: 247/255, alpha: 1),
                                                  titleColor: UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1))
      let alertView = SCLAlertView(appearance: appearance)
      alertView.addButton("UNDERSTOOD",
                          backgroundColor: UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1),
                          textColor: UIColor.white) {
                            self.performSegue(withIdentifier: "unwindToLoginViewController", sender: self)
                          }
      return alertView
    }()
  }
}

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
  
  let customAlertViewAppearance = SCLAlertView.SCLAppearance(
    kTitleFont: UIFont(name: "AvenirNext-Medium", size: 19)!,
    kTextFont: UIFont(name: "AvenirNext-Regular", size: 15)!,
    kButtonFont: UIFont(name: "AvenirNext-Bold", size: 19)!
  )
  
  // MARK: - IBOutlet Properties
  
  @IBOutlet weak var emailLabel: UILabel!
  
  // MARK: - IBAction Properties
  
  @IBAction func resetPasswordButtonDidTouch(_ sender: UIButton) {    
    _ = SCLAlertView(appearance: self.customAlertViewAppearance).showTitle("Request Sent", subTitle: "Please check \(self.emailAddress) for verification link.", style: .info, closeButtonTitle: "UNDERSTOOD", colorStyle: 0x7AD8C0)
  }
  
  // MARK: - UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.emailLabel.text = self.emailAddress
  }
}

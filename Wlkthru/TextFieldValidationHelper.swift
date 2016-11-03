//
//  TextFieldValidationHelper.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 9/19/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class TextFieldValidationHelper {
  
  // MARK: - Class Methods
  
  static func toggleStateFor(button: UIButton, dependingOn emailTextField: UITextField, passwordTextField: UITextField, passwordConfirmationTextField: UITextField?) {
    if passwordConfirmationTextField == nil {
      button.isEnabled = emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true ? false : true
    }
    else {
      button.isEnabled = emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || passwordConfirmationTextField?.text?.isEmpty == true ? false : true
    }
  }
  
  static func validate(email emailTextField: UITextField, password passwordTextField: UITextField, passwordConfirmation passwordConfirmationTextField: UITextField?, beforeActivatingButton button: UIButton, insideViewController viewController: UIViewController, alsoCheckPasswordTextField: Bool = true) {
    
    let alertView: SCLAlertView = {
      let appearance = SCLAlertView.SCLAppearance(kTitleFont: UIFont(name: "AvenirNext-Bold", size: 20)!,
                                                  kTextFont: UIFont(name: "AvenirNext-Bold", size: 16)!,
                                                  kButtonFont: UIFont(name: "AvenirNext-Bold", size: 20)!,
                                                  showCloseButton: false,
                                                  contentViewColor: UIColor(red: 220/255, green: 1, blue: 247/255, alpha: 1),
                                                  titleColor: UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1))
      let alertView = SCLAlertView(appearance: appearance)
      return alertView
    }()
    
    viewController.view.endEditing(true)
    
    guard let nonBlankEmailEntry = emailTextField.text, EmailValidationHelper.check(nonBlankEmailEntry) else {
      
      alertView.addButton("NOTED",
                          backgroundColor: UIColor(red: 193/255, green: 39/255, blue: 45/255, alpha: 1),
                          textColor: UIColor.white) { emailTextField.becomeFirstResponder() }
      alertView.showError("Invalid Email Address", subTitle: "Please try again.")
      
      return
    }
    
    if alsoCheckPasswordTextField == true {
      guard let nonBlankPasswordEntry = passwordTextField.text, nonBlankPasswordEntry.characters.count >= 6 else {
        passwordConfirmationTextField?.text = nil
        
        alertView.addButton("GOT IT",
                            backgroundColor: UIColor(red: 193/255, green: 39/255, blue: 45/255, alpha: 1),
                            textColor: UIColor.white) { passwordTextField.becomeFirstResponder() }
        alertView.showError("Password is Too Short", subTitle: "Please enter 6 or more characters.")
        
        return
      }
      
      if viewController is LoginViewController {
        viewController.dismiss(animated: true, completion: nil)
        viewController.view.endEditing(true)
      }
    }
      
    else {
      viewController.performSegue(withIdentifier: "ForgotMyPasswordSegue", sender: viewController)
    }
    
    if viewController is NewAccountViewController {
      guard let nonBlankPasswordConfirmationEntry = passwordConfirmationTextField?.text, passwordTextField.text == nonBlankPasswordConfirmationEntry else {
        passwordConfirmationTextField?.text = nil
        
        alertView.addButton("OKIE DOKIE",
                            backgroundColor: UIColor(red: 193/255, green: 39/255, blue: 45/255, alpha: 1),
                            textColor: UIColor.white) { passwordTextField.becomeFirstResponder() }
        alertView.showError("Different Passwords", subTitle: "Please retype both passwords.")
        
        return
      }
      
      alertView.addButton("AWESOME",
                          backgroundColor: UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1),
                          textColor: UIColor.white) { viewController.dismiss(animated: true, completion: nil) }
      alertView.showTitle("Account Created",
                          subTitle: "Please check \(nonBlankEmailEntry) for email verification.",
                          style: SCLAlertViewStyle.success,
                          colorStyle: 0x7AD8C0)
    }
  }
}

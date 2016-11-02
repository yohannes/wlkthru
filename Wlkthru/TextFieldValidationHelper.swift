//
//  TextFieldValidationHelper.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 9/19/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class TextFieldValidationHelper {
  
  // MARK: - Stored Properties
  
  static let emailEntryAlertView: FCAlertView = {
    let alertView = FCAlertView(type: FCAlertType.warning)
    alertView.hideDoneButton = true
    return alertView
  }()
  
  static let passwordEntryAlertView: FCAlertView = {
    let alertView = FCAlertView(type: .warning)
    alertView.hideDoneButton = true
    return alertView
  }()
  
  static let passwordReEntryAlertView: FCAlertView = {
    let alertView = FCAlertView(type: .warning)
    alertView.hideDoneButton = true
    return alertView
  }()
  
  static let successfulAccountCreationAlertView: FCAlertView = {
    let alertView = FCAlertView(type: .success)
    alertView.colorScheme = UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1)
    return alertView
  }()
  
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
    
    guard let nonBlankEmailEntry = emailTextField.text, EmailValidationHelper.check(nonBlankEmailEntry) else {
      emailTextField.becomeFirstResponder()
      
      self.emailEntryAlertView.showAlert(inView: viewController,
                                    withTitle: "Invalid Email Address",
                                    withSubtitle: "Please try again.",
                                    withCustomImage: nil,
                                    withDoneButtonTitle: nil,
                                    andButtons: ["UNDERSTOOD"])
      
      return
    }
    
    if alsoCheckPasswordTextField == true {
      guard let nonBlankPasswordEntry = passwordTextField.text, nonBlankPasswordEntry.characters.count >= 6 else {
        passwordTextField.becomeFirstResponder()
        passwordConfirmationTextField?.text = nil
        
        self.passwordEntryAlertView.showAlert(inView: viewController,
                                              withTitle: "Password is Too Short",
                                              withSubtitle: "Please enter 6 or more characters.",
                                              withCustomImage: nil,
                                              withDoneButtonTitle: nil,
                                              andButtons: ["GOT IT"])
        
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
        passwordTextField.becomeFirstResponder()
        passwordConfirmationTextField?.text = nil
        
        self.passwordReEntryAlertView.showAlert(inView: viewController,
                                              withTitle: "Different Passwords",
                                              withSubtitle: "Please retype both passwords.",
                                              withCustomImage: nil,
                                              withDoneButtonTitle: nil,
                                              andButtons: ["OKIE DOKIE"])
        
        return
      }
      
      self.successfulAccountCreationAlertView.showAlert(inView: viewController,
                                                        withTitle: "Account Created",
                                                        withSubtitle: "Please check \(nonBlankEmailEntry) for email verification.",
                                                        withCustomImage: nil,
                                                        withDoneButtonTitle: "AWESOME",
                                                        andButtons: nil)
    }
  }
}

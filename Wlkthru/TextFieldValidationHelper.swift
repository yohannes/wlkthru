//
//  TextFieldValidationHelper.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 9/19/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class TextFieldValidationHelper {
  
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
      
      let emailEntryAlertController = UIAlertController(title: "Invalid Email Address", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
      let emailEntryAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
        toggleStateFor(button: button, dependingOn: emailTextField, passwordTextField: passwordTextField, passwordConfirmationTextField: passwordConfirmationTextField)
      })
      emailEntryAlertController.addAction(emailEntryAlertAction)
      viewController.present(emailEntryAlertController, animated: true, completion: nil)
      
      return
    }
    
    if alsoCheckPasswordTextField == true {
      guard let nonBlankPasswordEntry = passwordTextField.text, nonBlankPasswordEntry.characters.count >= 6 else {
        passwordTextField.becomeFirstResponder()
        
        passwordConfirmationTextField?.text = nil
        
        let passwordEntryAlertController = UIAlertController(title: "Inadequate Password Length", message: "Please enter 6 or more characters.", preferredStyle: .alert)
        passwordEntryAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
          toggleStateFor(button: button, dependingOn: emailTextField, passwordTextField: passwordTextField, passwordConfirmationTextField: passwordConfirmationTextField)
        }))
        viewController.present(passwordEntryAlertController, animated: true, completion: nil)
        
        return
      }
      
      if viewController is LoginViewController {
        viewController.dismiss(animated: true, completion: nil)
        viewController.view.endEditing(true)
      }
    }
    
    if viewController is NewAccountViewController {
      guard let nonBlankPasswordConfirmationEntry = passwordConfirmationTextField?.text, passwordTextField.text == nonBlankPasswordConfirmationEntry else {
        passwordTextField.becomeFirstResponder()
        
        passwordConfirmationTextField?.text = nil
        
        let passwordReentryAlertController = UIAlertController(title: "Different Passwords", message: "Please try again.", preferredStyle: .alert)
        passwordReentryAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
          toggleStateFor(button: button, dependingOn: emailTextField, passwordTextField: passwordTextField, passwordConfirmationTextField: passwordConfirmationTextField)
        }))
        viewController.present(passwordReentryAlertController, animated: true, completion: nil)
        return
      }
    
      viewController.view.endEditing(true)
      
      guard let validEmail = emailTextField.text else { return }
      let successfulAccountCreationAlertController = UIAlertController(title: "Account Successfully Created", message: "Please check \(validEmail) for email verification.", preferredStyle: .alert)
      successfulAccountCreationAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        viewController.dismiss(animated: true, completion: nil)
      }))
      viewController.present(successfulAccountCreationAlertController, animated: true, completion: nil)
    }
  }
}

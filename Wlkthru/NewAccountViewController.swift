//
//  NewAccountViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/26/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class NewAccountViewController: UIViewController {
  
  // MARK: - IBOutlet Properties
  
  @IBOutlet weak var emailTextField: YSWTextFieldWithCharacterCounter!
  @IBOutlet weak var passwordTextField: YSWTextFieldWithCharacterCounter!
  @IBOutlet weak var passwordConfirmationTextField: YSWTextFieldWithCharacterCounter!
  @IBOutlet weak var registerButton: UIButton!
  
  // MARK: - IBAction Methods
  
  @IBAction func cancelButtonDidTouch(_ sender: UIBarButtonItem) {
    self.view.endEditing(true)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func termsAndConditionsButtonDidTouch(_ sender: UIButton) {
    self.view.endEditing(true)
    
    self.emailTextField.text = ""
    self.passwordTextField.text = ""
    self.passwordConfirmationTextField.text = ""
    
    self.registerButton.isEnabled = false
  }
  
  @IBAction func registerButtonDidTouch(_ sender: UIButton) {
    self.validateAllTextFieldsAndConfirmAccountCreation()
  }
  
  // MARK: - UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.emailTextField.yswTextFieldWithCharacterCounterDelegate = self
    self.passwordTextField.yswTextFieldWithCharacterCounterDelegate = self
    self.passwordConfirmationTextField.yswTextFieldWithCharacterCounterDelegate = self
    
    self.emailTextField.becomeFirstResponder()
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    self.registerButton.isEnabled = false
    
    self.emailTextField.clearsOnBeginEditing = true
    self.passwordTextField.clearsOnBeginEditing = true
    self.passwordConfirmationTextField.clearsOnBeginEditing = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    self.emailTextField.becomeFirstResponder()
  }
  
  // MARK: - Helper Methods
  
  func checkAllTextFieldsAreFilled() {
    self.registerButton.isEnabled = (self.emailTextField.text?.isEmpty)! == true || (self.passwordTextField.text?.isEmpty)! == true || (self.passwordConfirmationTextField.text?.isEmpty)! == true ? false : true
  }
  
  fileprivate func validateAllTextFieldsAndConfirmAccountCreation() {
    guard let nonBlankEmailEntry = self.emailTextField.text, EmailValidationHelper.check(nonBlankEmailEntry) else {
      if self.presentedViewController == nil {
        self.emailTextField.becomeFirstResponder()
        
        let emailEntryAlertController = UIAlertController(title: "Invalid Email Address", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
        let emailEntryAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
          self.checkAllTextFieldsAreFilled()
        })
        emailEntryAlertController.addAction(emailEntryAlertAction)
        
        self.present(emailEntryAlertController, animated: true, completion: nil)
      }
      return
    }
    
    guard let nonBlankPasswordEntry = self.passwordTextField.text, nonBlankPasswordEntry.characters.count >= 6 else {
      if self.presentedViewController == nil {
        self.passwordTextField.becomeFirstResponder()
        
        self.passwordConfirmationTextField.text = nil
        
        let passwordEntryAlertController = UIAlertController(title: "Inadequate Password Length", message: "Please enter 6 or more characters.", preferredStyle: .alert)
        passwordEntryAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
          self.checkAllTextFieldsAreFilled()
        }))
        
        self.present(passwordEntryAlertController, animated: true, completion: nil)
      }
      return
    }
    
    guard let nonBlankPasswordConfirmationEntry = self.passwordConfirmationTextField.text, self.passwordTextField.text == nonBlankPasswordConfirmationEntry else {
      if self.presentedViewController == nil {
        self.passwordTextField.becomeFirstResponder()
        
        self.passwordConfirmationTextField.text = nil
        
        let passwordReentryAlertController = UIAlertController(title: "Different Passwords", message: "Please try again.", preferredStyle: .alert)
        passwordReentryAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
          self.checkAllTextFieldsAreFilled()
        }))
        
        self.present(passwordReentryAlertController, animated: true, completion: nil)
      }
      return
    }
    
    self.view.endEditing(true)
    
    if self.presentedViewController == nil {
      guard let validEmail = self.emailTextField.text else { return }
      let successfulAccountCreationAlertController = UIAlertController(title: "Account Successfully Created", message: "Please check \(validEmail) for email verification.", preferredStyle: .alert)
      successfulAccountCreationAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        self.dismiss(animated: true, completion: nil)
      }))
      
      self.present(successfulAccountCreationAlertController, animated: true, completion: nil)
    }
  }
}

// MARK: - UITextFieldDelegate

extension NewAccountViewController: YSWTextFieldWithCharacterCounterDelegate {
  func shouldReturn(_ textField: UITextField) -> Bool {
    if case 0 = textField.tag {
      self.passwordTextField.becomeFirstResponder()
    }
    else if case 1 = textField.tag {
      self.passwordConfirmationTextField.becomeFirstResponder()
    }
    else if case 2 = textField.tag {
      self.validateAllTextFieldsAndConfirmAccountCreation()
    }
    return true
  }
  
  func shouldEndEditing(_ textField: UITextField) -> Bool {
    self.emailTextField.addTarget(self, action: #selector(NewAccountViewController.checkAllTextFieldsAreFilled), for: UIControlEvents.editingChanged)
    self.passwordConfirmationTextField.addTarget(self, action: #selector(NewAccountViewController.checkAllTextFieldsAreFilled), for: .editingChanged)
    self.passwordTextField.addTarget(self, action: #selector(NewAccountViewController.checkAllTextFieldsAreFilled), for: .editingChanged)
    
    return true
  }
}

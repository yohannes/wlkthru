//
//  LoginViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/26/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  // MARK: - IBOutlet Properties
  
  @IBOutlet weak var emailTextField: YSWTextFieldWithCharacterCounter!
  @IBOutlet weak var passwordTextField: YSWTextFieldWithCharacterCounter!
  @IBOutlet weak var loginButton: UIButton!
  
  // MARK: - IBAction Properties
  
  @IBAction func cancelButtonDidTouch(_ sender: UIBarButtonItem) {
    self.view.endEditing(true)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func forgotPasswordButtonDidTouch(_ sender: UITapGestureRecognizer) {
    self.validateTextFieldEntry(includingPasswordTextField: false)
    self.performSegue(withIdentifier: "ForgotMyPasswordSegue", sender: self)
  }
  
  @IBAction func loginButtonDidTouch(_ sender: UIButton) {
    self.validateTextFieldEntry()
  }
  
  @IBAction func unwindToLoginViewController(_ segue: UIStoryboardSegue) {}
  
  // MARK: - UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.emailTextField.yswTextFieldWithCharacterCounterDelegate = self
    self.passwordTextField.yswTextFieldWithCharacterCounterDelegate = self
    
    self.loginButton.isEnabled = false
    
    self.emailTextField.becomeFirstResponder()
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    self.emailTextField.clearsOnBeginEditing = true
    self.passwordTextField.clearsOnBeginEditing = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    if NSString(string: self.emailTextField.text!).length > 0 {
      self.passwordTextField.becomeFirstResponder()
    }
    else {
      self.emailTextField.becomeFirstResponder()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ForgotMyPasswordSegue" {
      guard let validForgotPasswordViewController = segue.destination as? ForgotPasswordViewController else { return }
      validForgotPasswordViewController.emailAddress = self.emailTextField.text!
    }
  }
  
  // MARK: - Helper Methods
  
  func checkAllTextFieldsAreFilled() {
    self.loginButton.isEnabled = (self.emailTextField.text?.isEmpty)! == true || (self.passwordTextField.text?.isEmpty)! == true ? false : true
  }
  
  fileprivate func validateTextFieldEntry(includingPasswordTextField: Bool = true) {
    guard let nonBlankEmailEntry = self.emailTextField.text, EmailValidationHelper.check(nonBlankEmailEntry) else {
      self.emailTextField.becomeFirstResponder()
      
      let emailEntryAlertController = UIAlertController(title: "Invalid Email Address", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
      emailEntryAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
      self.present(emailEntryAlertController, animated: true, completion: nil)
      
      return
    }
    
    if includingPasswordTextField == true {
      guard let nonBlankPasswordEntry = self.passwordTextField.text, nonBlankPasswordEntry.characters.count >= 6 else {
        self.passwordTextField.becomeFirstResponder()
        
        let passwordEntryAlertController = UIAlertController(title: "Invalid Password Length", message: "Please enter 6 or more characters.", preferredStyle: .alert)
        passwordEntryAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(passwordEntryAlertController, animated: true, completion: nil)
        
        return
      }
      self.dismiss(animated: true, completion: nil)
    }
    self.view.endEditing(true)
  }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: YSWTextFieldWithCharacterCounterDelegate {
  func shouldReturn(_ textField: UITextField) -> Bool {
    if case 0 = textField.tag {
      self.passwordTextField.becomeFirstResponder()
    }
    else if case 1 = textField.tag {
      self.validateTextFieldEntry()
    }
    return true
  }
  
  func shouldEndEditing(_ textField: UITextField) -> Bool {
    self.emailTextField.addTarget(self, action: #selector(LoginViewController.checkAllTextFieldsAreFilled), for: UIControlEvents.editingChanged)
    self.passwordTextField.addTarget(self, action: #selector(LoginViewController.checkAllTextFieldsAreFilled), for: .editingChanged)
    return true
  }
}

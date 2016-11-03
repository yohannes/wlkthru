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
    TextFieldValidationHelper.validate(email: emailTextField,
                                       password: passwordTextField,
                                       passwordConfirmation: nil,
                                       beforeActivatingButton: loginButton,
                                       insideViewController: self,
                                       alsoCheckPasswordTextField: false)
  }
  
  @IBAction func loginButtonDidTouch(_ sender: UIButton) {
    TextFieldValidationHelper.validate(email: emailTextField,
                                       password: passwordTextField,
                                       passwordConfirmation: nil,
                                       beforeActivatingButton: loginButton,
                                       insideViewController: self)
  }
  
  @IBAction func unwindToLoginViewController(_ segue: UIStoryboardSegue) {}
  
  // MARK: - UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.emailTextField.yswTextFieldWithCharacterCounterDelegate = self
    self.passwordTextField.yswTextFieldWithCharacterCounterDelegate = self
    
    TextFieldValidationHelper.emailEntryAlertView.delegate = self
    TextFieldValidationHelper.passwordEntryAlertView.delegate = self
    
    self.loginButton.isEnabled = false
    
    self.emailTextField.becomeFirstResponder()
  
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    self.emailTextField.clearsOnBeginEditing = true
    self.passwordTextField.clearsOnBeginEditing = true
    
    self.emailTextField.nextTextField = self.passwordTextField
    
    self.emailTextField.font = UIFont(name: "AvenirNext-Bold", size: 19)
    self.emailTextField.textColor = UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1)
    self.passwordTextField.font = UIFont(name: "AvenirNext-Bold", size: 19)
    self.passwordTextField.textColor = UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1)
    
    self.emailTextField.attributedPlaceholder = TextFieldPlaceHolderHelper.createAttributedString(from: "Email")
    self.passwordTextField.attributedPlaceholder = TextFieldPlaceHolderHelper.createAttributedString(from: "Password")
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
    TextFieldValidationHelper.toggleStateFor(button: loginButton, dependingOn: emailTextField, passwordTextField: passwordTextField, passwordConfirmationTextField: nil)
  }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: YSWTextFieldWithCharacterCounterDelegate {
  func shouldReturn(_ textField: UITextField) -> Bool {
    if case 0 = textField.tag {
      self.passwordTextField.becomeFirstResponder()
    }
    else if case 1 = textField.tag {
      TextFieldValidationHelper.validate(email: emailTextField,
                                         password: passwordTextField,
                                         passwordConfirmation: nil,
                                         beforeActivatingButton: loginButton,
                                         insideViewController: self)
    }
    return true
  }
  
  func shouldEndEditing(_ textField: UITextField) -> Bool {
    self.emailTextField.addTarget(self, action: #selector(LoginViewController.checkAllTextFieldsAreFilled), for: UIControlEvents.editingChanged)
    self.passwordTextField.addTarget(self, action: #selector(LoginViewController.checkAllTextFieldsAreFilled), for: .editingChanged)
    return true
  }
}

extension LoginViewController: FCAlertViewDelegate {
  func alertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
    TextFieldValidationHelper.toggleStateFor(button: loginButton, dependingOn: emailTextField, passwordTextField: passwordTextField, passwordConfirmationTextField: nil)
    if title == "UNDERSTOOD" {
      self.emailTextField.becomeFirstResponder()
    }
    else if title == "GOT IT" {
      self.passwordTextField.becomeFirstResponder()
    }
  }
  
  func FCAlertViewWillAppear(_ alertView: FCAlertView) {
    self.view.endEditing(true)
  }
}

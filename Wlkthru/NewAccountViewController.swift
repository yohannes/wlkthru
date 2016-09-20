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
    TextFieldValidationHelper.validate(email: emailTextField,
                                       password: passwordTextField,
                                       passwordConfirmation: passwordConfirmationTextField,
                                       beforeActivatingButton: registerButton,
                                       insideViewController: self)
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
  
  func validateAllTextFieldsAreFilled() {
    TextFieldValidationHelper.toggleStateFor(button: registerButton, dependingOn: emailTextField, passwordTextField: passwordTextField, passwordConfirmationTextField: passwordConfirmationTextField)
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
      TextFieldValidationHelper.validate(email: emailTextField,
                                         password: passwordTextField,
                                         passwordConfirmation: passwordConfirmationTextField,
                                         beforeActivatingButton: registerButton,
                                         insideViewController: self)
    }
    return true
  }
  
  func shouldEndEditing(_ textField: UITextField) -> Bool {
    self.emailTextField.addTarget(self, action: #selector(NewAccountViewController.validateAllTextFieldsAreFilled), for: UIControlEvents.editingChanged)
    self.passwordConfirmationTextField.addTarget(self, action: #selector(NewAccountViewController.validateAllTextFieldsAreFilled), for: .editingChanged)
    self.passwordTextField.addTarget(self, action: #selector(NewAccountViewController.validateAllTextFieldsAreFilled), for: .editingChanged)
    
    return true
  }
}

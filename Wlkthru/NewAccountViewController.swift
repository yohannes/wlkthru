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
    
    TextFieldValidationHelper.emailEntryAlertView.delegate = self
    TextFieldValidationHelper.passwordEntryAlertView.delegate = self
    TextFieldValidationHelper.passwordReEntryAlertView.delegate = self
    TextFieldValidationHelper.successfulAccountCreationAlertView.delegate = self

    self.emailTextField.becomeFirstResponder()
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    
    self.registerButton.isEnabled = false
    
    self.emailTextField.clearsOnBeginEditing = true
    self.passwordTextField.clearsOnBeginEditing = true
    self.passwordConfirmationTextField.clearsOnBeginEditing = true
    
    self.emailTextField.nextTextField = self.passwordTextField
    self.passwordTextField.nextTextField = self.passwordConfirmationTextField
    
    self.emailTextField.font = UIFont(name: "AvenirNext-Bold", size: 19)
    self.emailTextField.textColor = UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1)
    self.passwordTextField.font = UIFont(name: "AvenirNext-Bold", size: 19)
    self.passwordTextField.textColor = UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1)
    self.passwordConfirmationTextField.font = UIFont(name: "AvenirNext-Bold", size: 19)
    self.passwordConfirmationTextField.textColor = UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1)
    
    self.emailTextField.attributedPlaceholder = TextFieldPlaceHolderHelper.createAttributedString(from: "Email")
    self.passwordTextField.attributedPlaceholder = TextFieldPlaceHolderHelper.createAttributedString(from: "Password (Min. 6 characters)")
    self.passwordConfirmationTextField.attributedPlaceholder = TextFieldPlaceHolderHelper.createAttributedString(from: "Confirm Password")
    
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

// MARK: - FCAlertViewDelegate

extension NewAccountViewController: FCAlertViewDelegate {
  func alertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
    TextFieldValidationHelper.toggleStateFor(button: registerButton, dependingOn: emailTextField, passwordTextField: passwordTextField, passwordConfirmationTextField: passwordConfirmationTextField)
    if title == "UNDERSTOOD" {
      self.emailTextField.becomeFirstResponder()
    }
    else if title == "GOT IT" {
      self.passwordTextField.becomeFirstResponder()
    }
    else if title == "OKIE DOKIE" {
      self.passwordTextField.becomeFirstResponder()
    }
  }
  
  func FCAlertViewWillAppear(_ alertView: FCAlertView) {
    self.view.endEditing(true)
  }
  
  func FCAlertDoneButtonClicked(_ alertView: FCAlertView) {
    self.dismiss(animated: true, completion: nil)
  }
}

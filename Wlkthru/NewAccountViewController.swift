//
//  NewAccountViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/26/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class NewAccountViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Stored Properties
    
    var isCancelButtonTouched: Bool!
    var isTermsConditionsButtonTouched: Bool!
    
    // MARK: - IBOutlet Methods
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var termsConditionsButton: UIButton!
    
    // MARK: - IBAction Methods
    
    @IBAction func cancelButtonDidTouch(sender: UIBarButtonItem) {
        self.isCancelButtonTouched = true
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func termsAndConditionsButtonDidTouch(sender: UIButton) {
        self.isTermsConditionsButtonTouched = true
        self.view.endEditing(true)
        
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.passwordConfirmationTextField.text = ""
        
        self.registerButton.enabled = false
    }
    
    @IBAction func registerButtonDidTouch(sender: UIButton) {
        guard let nonBlankEmailEntry = self.emailTextField.text where EmailValidationHelper.check(nonBlankEmailEntry) else {
            if self.presentedViewController == nil {
                self.emailTextField.becomeFirstResponder()
                
                let emailEntryAlertController = UIAlertController(title: "Invalid Email Address", message: "Please double check and enter again.", preferredStyle: UIAlertControllerStyle.Alert)
                let emailEntryAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                emailEntryAlertController.addAction(emailEntryAlertAction)
                
                self.presentViewController(emailEntryAlertController, animated: true, completion: nil)
            }
            return
        }

        guard let nonBlankPasswordEntry = self.passwordTextField.text where nonBlankPasswordEntry.characters.count >= 6 else {
            if self.presentedViewController == nil {
                self.passwordTextField.becomeFirstResponder()
                
                let passwordEntryAlertController = UIAlertController(title: "Invalid Password Length", message: "Please enter 6 or more characters", preferredStyle: .Alert)
                passwordEntryAlertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                self.presentViewController(passwordEntryAlertController, animated: true, completion: nil)
            }
            return
        }
        
        guard let nonBlankPasswordConfirmationEntry = self.passwordConfirmationTextField.text where self.passwordTextField.text == nonBlankPasswordConfirmationEntry else {
            if self.presentedViewController == nil {
                self.passwordConfirmationTextField.becomeFirstResponder()
                
                let passwordReentryAlertController = UIAlertController(title: "Password is Not the Same", message: "Please double check and enter again.", preferredStyle: .Alert)
                passwordReentryAlertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                self.presentViewController(passwordReentryAlertController, animated: true, completion: nil)
            }
            return
        }
        
        self.view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if self.isCancelButtonTouched == true || self.isTermsConditionsButtonTouched == true {
            return true
        }
        
        self.emailTextField.addTarget(self, action: #selector(NewAccountViewController.checkAllPasswordTextFieldsAreFilled), forControlEvents: UIControlEvents.EditingChanged)
        self.passwordConfirmationTextField.addTarget(self, action: #selector(NewAccountViewController.checkAllPasswordTextFieldsAreFilled), forControlEvents: .EditingChanged)
        self.passwordTextField.addTarget(self, action: #selector(NewAccountViewController.checkAllPasswordTextFieldsAreFilled), forControlEvents: .EditingChanged)
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if case 0 = textField.tag {
            self.passwordTextField.becomeFirstResponder()
        }
        else if case 1 = textField.tag {
            self.passwordConfirmationTextField.becomeFirstResponder()
        }
        else if case 2 = textField.tag {
            self.registerButton.becomeFirstResponder()
            self.view.endEditing(true)
        }
        return true
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isCancelButtonTouched = false
        self.isTermsConditionsButtonTouched = false
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmationTextField.delegate = self
        
        self.emailTextField.becomeFirstResponder()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.registerButton.enabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.isTermsConditionsButtonTouched = false
        self.emailTextField.becomeFirstResponder()
    }
    
    // MARK: - Helper Methods
    
    func checkAllPasswordTextFieldsAreFilled() {
        self.registerButton.enabled = (self.emailTextField.text?.isEmpty)! == true || (self.passwordTextField.text?.isEmpty)! == true || (self.passwordConfirmationTextField.text?.isEmpty)! == true ? false : true
    }
}

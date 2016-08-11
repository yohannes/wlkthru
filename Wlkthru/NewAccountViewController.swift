//
//  NewAccountViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/26/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

//  TODO: 1) check password reentry verification upon register button click event instead at textfield delegate method

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
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if self.isCancelButtonTouched == true || self.isTermsConditionsButtonTouched == true {
            return true
        }
        guard let nonBlankEmailEntry = self.emailTextField.text where EmailValidationHelper.check(nonBlankEmailEntry) else {
            if self.presentedViewController == nil {
                let emailEntryAlertController = UIAlertController(title: "Invalid Email Address", message: "Please double check and enter again.", preferredStyle: UIAlertControllerStyle.Alert)
                let emailEntryAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                emailEntryAlertController.addAction(emailEntryAlertAction)
                self.presentViewController(emailEntryAlertController, animated: true, completion: nil)
            }
            return false
        }
        if case 1 = textField.tag {
            guard let nonBlankPasswordEntry = self.passwordTextField.text where nonBlankPasswordEntry.characters.count >= 6 else {
                if self.presentedViewController == nil {
                    let passwordEntryAlertController = UIAlertController(title: "Invalid Password Length", message: "Please enter 6 or more characters", preferredStyle: .Alert)
                    passwordEntryAlertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(passwordEntryAlertController, animated: true, completion: nil)
                }
                return false
            }
        }
        else if case 2 = textField.tag {
            guard let nonBlankPasswordConfirmationEntry = self.passwordConfirmationTextField.text where self.passwordTextField.text == nonBlankPasswordConfirmationEntry else {
                if self.presentedViewController == nil {
                    let passwordReentryAlertController = UIAlertController(title: "Password is Not the Same", message: "Please double check and enter again.", preferredStyle: .Alert)
                    passwordReentryAlertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(passwordReentryAlertController, animated: true, completion: nil)
                }
                return false
            }
        }
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.isTermsConditionsButtonTouched = false
        self.emailTextField.becomeFirstResponder()
    }
}

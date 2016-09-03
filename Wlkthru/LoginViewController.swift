//
//  LoginViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/26/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - IBAction Properties
    
    @IBAction func cancelButtonDidTouch(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotPasswordButtonDidTouch(_ sender: UITapGestureRecognizer) {
        self.validateEmailEntry()
        self.performSegue(withIdentifier: "ForgotMyPasswordSegue", sender: self)
    }
    
    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
        self.validateEmailEntry()
    }
    
    @IBAction func unwindToLoginViewController(_ segue: UIStoryboardSegue) {}
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.emailTextField.addTarget(self, action: #selector(LoginViewController.checkAllTextFieldsAreFilled), for: UIControlEvents.editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(LoginViewController.checkAllTextFieldsAreFilled), for: .editingChanged)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if case 0 = textField.tag {
            self.passwordTextField.becomeFirstResponder()
        }
        else if case 1 = textField.tag {
            self.validateEmailEntry()
        }
        return true
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.loginButton.isEnabled = false

        self.emailTextField.becomeFirstResponder()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    fileprivate func validateEmailEntry() {
        guard let nonBlankEmailEntry = self.emailTextField.text, EmailValidationHelper.check(nonBlankEmailEntry) else {
            let alertController = UIAlertController(title: "Invalid Email Address", message: "Please double check and enter again.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                self.emailTextField.becomeFirstResponder()
            }))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let nonBlankPasswordEntry = self.passwordTextField.text, nonBlankPasswordEntry.characters.count >= 6 else {
            let passwordEntryAlertController = UIAlertController(title: "Invalid Password Length", message: "Please enter 6 or more characters", preferredStyle: .alert)
            passwordEntryAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                self.passwordTextField.becomeFirstResponder()
            }))
            self.present(passwordEntryAlertController, animated: true, completion: nil)
            return
        }
        
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}

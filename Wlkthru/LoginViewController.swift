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
    
    @IBAction func checkPasswordTextFieldIsFilled(_ sender: UITextField) {
        self.loginButton.isEnabled = (sender.text?.isEmpty)! ? false : true
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !(self.emailTextField.text?.isEmpty)! && !(self.passwordTextField.text?.isEmpty)! {
            self.view.endEditing(true)
        }
        else if !(self.emailTextField.text?.isEmpty)! {
            self.passwordTextField.becomeFirstResponder()
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
    
    fileprivate func validateEmailEntry() {
        guard let nonBlankEmailEntry = self.emailTextField.text, EmailValidationHelper.check(nonBlankEmailEntry) else {
            let alertController = UIAlertController(title: "Invalid Email Address", message: "Please double check and enter again.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                self.emailTextField.becomeFirstResponder()
            }))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        self.view.endEditing(true)
    }
}

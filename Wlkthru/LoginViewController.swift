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
    
    @IBAction func cancelButtonDidTouch(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func checkPasswordTextFieldIsFilled(sender: UITextField) {
        self.loginButton.enabled = (sender.text?.isEmpty)! ? false : true
    }
    
    @IBAction func forgotPasswordButtonDidTouch(sender: UITapGestureRecognizer) {
        self.validateEmailEntry()
        self.performSegueWithIdentifier("ForgotMyPasswordSegue", sender: self)
    }
    
    @IBAction func loginButtonDidTouch(sender: UIButton) {
        self.validateEmailEntry()
    }
    
    @IBAction func unwindToLoginViewController(segue: UIStoryboardSegue) {}
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
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
        
        self.loginButton.enabled = false

        self.emailTextField.becomeFirstResponder()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        if NSString(string: self.emailTextField.text!).length > 0 {
            self.passwordTextField.becomeFirstResponder()
        }
        else {
            self.emailTextField.becomeFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ForgotMyPasswordSegue" {
            guard let validForgotPasswordViewController = segue.destinationViewController as? ForgotPasswordViewController else { return }
            validForgotPasswordViewController.emailAddress = self.emailTextField.text!
        }
    }
    
    // MARK: - Helper Methods
    
    // FIXME: Console log error: "pushViewController:animated: called on <UINavigationController 0x7fa0d3866000> while an existing transition or presentation is occurring; the navigation stack will not be updated."
    
    private func validateEmailEntry() {
        guard let nonBlankEmailEntry = self.emailTextField.text where EmailValidationHelper.check(nonBlankEmailEntry) else {
            let alertController = UIAlertController(title: "Invalid Email Address", message: "Please double check and enter again.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { [unowned self] (_) in
                self.emailTextField.becomeFirstResponder()
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        self.view.endEditing(true)
    }
}

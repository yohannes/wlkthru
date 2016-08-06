//
//  LoginViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/26/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

// FIXME: tap close to get out but no email address will launch alert controller


import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBAction Properties
    
    @IBAction func cancelButtonDidTouch(sender: UIBarButtonItem) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func forgotPasswordButtonDidTouch(sender: UIButton) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func loginButtonDidTouch(sender: UIButton) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        guard self.validateEmail(self.emailTextField.text!) else {
            let alertController = UIAlertController(title: "Warning", message: "Please enter a valid email address", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            // FIXME:
            self.presentViewController(alertController, animated: true, completion: nil)
            self.emailTextField.becomeFirstResponder()
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if !(self.emailTextField.text?.isEmpty)! && !(self.passwordTextField.text?.isEmpty)! {
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
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

        self.emailTextField.becomeFirstResponder()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.emailTextField.becomeFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ForgotMyPasswordSegue" {
            guard let validForgotPasswordViewController = segue.destinationViewController as? ForgotPasswordViewController else { return }
            validForgotPasswordViewController.emailAddress = self.emailTextField.text!
        }
    }

    // MARK: - Helper Methods
    
    private func validateEmail(emailString: NSString) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailText = NSPredicate(format: "SELF MATCHES [c]%@", emailRegex)
        return (emailText.evaluateWithObject(emailString))
    }
}

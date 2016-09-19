//
//  YSWTextFieldWithCharacterCounter.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 9/6/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

protocol YSWTextFieldWithCharacterCounterDelegate: class {
  func shouldEndEditing(_ textField: UITextField) -> Bool
  func shouldReturn(_ textField: UITextField) -> Bool
}

@IBDesignable class YSWTextFieldWithCharacterCounter: UITextField {
  
  // MARK: - Stored Properties
  
  fileprivate let countLabel = UILabel()
  
  @IBInspectable var lengthLimit: Int = 0
  @IBInspectable var countLabelTextColor: UIColor = UIColor.black
  
  weak var yswTextFieldWithCharacterCounterDelegate: YSWTextFieldWithCharacterCounterDelegate?
  
  // MARK: - Instance Methods
  
  fileprivate func setCountLabel() {
    self.rightViewMode = .whileEditing
    self.countLabel.font = self.font?.withSize(13.0)
    self.countLabel.textColor = self.countLabelTextColor
    self.countLabel.textAlignment = .left
    self.countLabel.text = self.setInitialCounterValue(text: self.text)
    self.rightView = self.countLabel
    
    if let validText = self.text {
      self.countLabel.text = "\(validText.utf16.count)/\(self.lengthLimit)"
    }
    else {
      self.countLabel.text = "0/\(self.lengthLimit)"
    }
  }
  
  fileprivate func setInitialCounterValue(text: String?) -> String {
    if let validText = text {
      return "\(validText.utf16.count)/\(self.lengthLimit)"
    }
    else {
      return "0/\(self.lengthLimit)"
    }
  }
  
  // MARK: - UIViewController Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.delegate = self
    
    if self.lengthLimit > 0 {
      self.setCountLabel()
    }
  }
  
  // MARK: - UITextField Methods
  
  override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    return self.lengthLimit > 0 ? CGRect(x: self.frame.width - 40, y: 0, width: 40, height: 30) : CGRect()
  }
  
}

// MARK: - UITextFieldDelegate Extension

extension YSWTextFieldWithCharacterCounter: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let validText = textField.text, self.lengthLimit != 0 else { return true }
    let newLength = validText.utf16.count + string.utf16.count - range.length
    if newLength <= self.lengthLimit {
      self.countLabel.text = "\(newLength)/\(self.lengthLimit)"
    }
    else {
      UIView.animate(withDuration: 0.1, animations: {
        self.countLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { (_) in
          UIView.animate(withDuration: 0.1, animations: {
            self.countLabel.transform = CGAffineTransform.identity
          })
      })
    }
    return newLength <= self.lengthLimit
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    self.countLabel.text = "0/\(self.lengthLimit)"
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    guard let validYSWTextFieldWithCharacterCounterDelegate = self.yswTextFieldWithCharacterCounterDelegate else { return false }
    return validYSWTextFieldWithCharacterCounterDelegate.shouldEndEditing(textField)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let validYSWTextFieldWithCharacterCounterDelegate = self.yswTextFieldWithCharacterCounterDelegate else { return false }
    return validYSWTextFieldWithCharacterCounterDelegate.shouldReturn(textField)
  }
}

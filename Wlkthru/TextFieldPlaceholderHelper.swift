//
//  TextFieldPlaceholderHelper.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 10/29/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class TextFieldPlaceHolderHelper {
  
  static func createAttributedString(from word: String) -> NSAttributedString {
    let attributedString = NSAttributedString(string: word, attributes: [NSFontAttributeName: UIFont(name: "AvenirNext-Bold", size: 19)!,
                                                                         NSForegroundColorAttributeName: UIColor(red: 122/255, green: 216/255, blue: 192/255, alpha: 1)])
    return attributedString
  }
}

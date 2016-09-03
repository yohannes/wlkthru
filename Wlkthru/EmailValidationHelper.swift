//
//  EmailValidationHelper.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 8/10/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import Foundation

class EmailValidationHelper {
    
    static func check(_ emailString: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailText = NSPredicate(format: "SELF MATCHES [c]%@", emailRegex)
        return (emailText.evaluate(with: emailString))
    }
}

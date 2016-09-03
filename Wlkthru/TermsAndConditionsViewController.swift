//
//  TermsAndConditionsViewController.swift
//  Wlkthru
//
//  Created by Yohannes Wijaya on 7/28/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    
    // MARK: - Stored Properties

    let termsAndConditions = "#####Credit Top Up\n" +
        "1. Prices are subject to change at any time without notice.\n" +
        "2. Wlkthru reserves the right to charge a convenience fee to consumers to use the service Wlkthru for credit top up.\n\n" +
        "#####Your Privacy\n" +
        "1. Email is required to register at Wlkthru. We do not use your phone number.\n" +
        "2. Password must be at least 6 characters long to ensure your safety. Letter or number can be used.\n" +
        "3. Keep your password secret from everyone.\n" +
        "4. Should you forget your password, simply tap on Forgot Your Password link.\n" +
        "5. You own the information you enter in Wlkthru. We don't transmit the data to anyone. Your data is 100% safe with us.\n\n" +
        "#####Changes\n" +
        "Wlkthru reserves the right to suspend / cancel, or discontinue any or all channels, products or services at any time without notice, make modifications and alterations in any or all of the content, products and services contained in the application without prior notice.\n\n" +
        "#####Copyrights and Trademarks\n" +
        "Unless otherwise stated, the copyright and all intellectual property rights in all material presented on the website and mobile applications (including but not limited to text, audio, video or graphical images), trademarks and logos appearing on the site and application smartfone are owned and protected by Indonesian laws and regulations.\n\n" +
        "You agree not to use framing techniques to enclose any trademark or logo or other proprietary information of ayopop; or remove, conceal or omit any copyright or other proprietary or CreditLine or dateline on the other mark or source identifier included on the Site / Service, including without limitation, the size, color, location or all proprietary brands. Each violation will be through the legal process.\n\n" +
        "#####Terms of Service\n" +
        "As a condition of use, you will not use the services of Wlkthru for any purpose that is unlawful or prohibited by these terms, conditions, and notices. You can not use the service Wlkthru in any manner that could damage, disable, overburden, or impair any of our servers, or networks connected to the enterprise server, or interfere with any other party's use and enjoyment of any service.\n\n" +
        "#####Account Termination\n" +
        "Our company has the right to;\n" +
        "1. Turn down service.\n" +
        "2. Restrict, suspend, or terminate your account.\n" +
        "3. Terminate this agreement.\n" +
        "4. Terimante or suspend your access to Wlkthru.\n" +
        "5. Refuse, move or remove for any reason any content / image you submit on or through the service.\n" +
        "6. Establish general practices and limits concerning use of the service at any time and,\n" +
        "7. Remove or edit content or cancel orders (entered by you) in its sole discretion with or without cause, and with or without prior notice for any violation of these Terms of Use.\n\n" +
        "#####Copyright Notice\n" +
        "Copyright © 2016, wlkthru.com (PT WLKTHRU TECHNOLOGY). All Rights Reserved.\n" +
        "This disclaimer / terms of service notifications are subject to change without notice.\n"
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let markdownParser = MarkdownParser()
        self.termsAndConditionsLabel.attributedText = markdownParser.parse(markdown: termsAndConditions)
    }
}

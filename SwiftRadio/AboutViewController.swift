//
//  AboutViewController.swift
//  Swift Radio
//
//  Created by Matthew Fecher on 7/9/15.
//  Copyright (c) 2015 MatthewFecher.com. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController {
    
    //*****************************************************************
    // MARK: - ViewDidLoad
    //*****************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    //*****************************************************************
    // MARK: - IBActions
    //*****************************************************************
    
    @IBAction func emailButtonDidTouch(_ sender: UIButton) {
        
        // Use your own email address & subject
        let receipients = ["radio@rawkous.com"]
        let subject = "From Rawkous Radio App"
        let messageBody = ""
        
        let configuredMailComposeViewController = configureMailComposeViewController(recepients: receipients, subject: subject, messageBody: messageBody)
        
        if canSendMail() {
            present(configuredMailComposeViewController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    @IBAction func websiteButtonDidTouch(_ sender: UIButton) {
        // Use your own website here
        guard let url = URL(string: "http://rawkous.com") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

  }

//*****************************************************************
// MARK: - MFMailComposeViewController Delegate
//*****************************************************************

extension AboutViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func configureMailComposeViewController(recepients: [String], subject: String, messageBody: String) -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(recepients)
        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        sendMailErrorAlert.addAction(cancelAction)
        present(sendMailErrorAlert, animated: true, completion: nil)
    }
}

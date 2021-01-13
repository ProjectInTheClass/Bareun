//
//  EmailViewController.swift
//  Bareun
//
//  Created by 김세영 on 2021/01/13.
//

import Foundation
import UIKit
import MessageUI

class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        super.viewDidLoad()
        
    }
    
    
    @IBAction func SendFeedbackButton(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self

            composeVC.setToRecipients(["Bareun@naver.com"])
            composeVC.setSubject("Message Subject")
            composeVC.setMessageBody("Message content", isHTML: false)

            self.present(composeVC, animated: true, completion: nil)
        }else{
            print("cannotsendmail")
        }
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
        
    }
}

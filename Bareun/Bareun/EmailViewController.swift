//
//  EmailViewController.swift
//  Bareun
//
//  Created by 김세영 on 2021/01/13.
//

import Foundation
import UIKit
import MessageUI

struct settingsMenu {
    var userSettingMenu: String
}

class EmailViewController: UIViewController,UITableViewDataSource ,MFMailComposeViewControllerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = settingMenuList[indexPath.row].userSettingMenu
        return cell
        
    }
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
//        if !MFMailComposeViewController.canSendMail() {
//            print("Mail services are not available")
//            return
//        }
        super.viewDidLoad()
    }
    
    var settingMenuList:[settingsMenu] = []

    
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

//
//  EmailViewController.swift
//  Bareun
//
//  Created by 김세영 on 2021/01/13.
//

import Foundation
import UIKit
import MessageUI
import SafariServices

struct settingsMenu {
    var userSettingMenu: String
}

class EmailViewController: UIViewController ,MFMailComposeViewControllerDelegate {
    
    
    
    @IBOutlet var tableView: UITableView!
    
    var settingMenuList = [
        "버전 정보 : 1.0",
        "바른 알아보기",
        "개발자에게 메일 보내기"
    ]
    
    override func viewDidLoad() {
//        if !MFMailComposeViewController.canSendMail() {
//            print("Mail services are not available")
//            return
//        }
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
        
    }
}

extension EmailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = settingMenuList[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 1:
            guard let url = URL(string: "https://projectintheclass.github.io/Bareun/index.html") else { return }
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)

        case 2:
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
        default:
            return
        }
        
    }
}

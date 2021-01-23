//
//  FontLicenseViewController.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/16.
//

import UIKit

class FontLicenseViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("shared : \(Shared.shared.licenseIndex)")
        switch Shared.shared.licenseIndex {
        case 5:
            if let filepath = Bundle.main.path(forResource: "OFL-Pinyon", ofType: "txt") {
                do {
                    let licenseScript = try String(contentsOfFile: filepath)
                    self.content.text = licenseScript
                } catch {}
            } else {
                print("file not found!")
            }
        case 6:
            if let filepath = Bundle.main.path(forResource: "OFL-Allan", ofType: "txt") {
                do {
                    let licenseScript = try String(contentsOfFile: filepath)
                    self.content.text = licenseScript
                } catch {}
            } else {
                print("file not found!")
            }
        case 7:
            if let filepath = Bundle.main.path(forResource: "OFL-Shadow", ofType: "txt") {
                do {
                    let licenseScript = try String(contentsOfFile: filepath)
                    self.content.text = licenseScript
                } catch {}
            } else {
                print("file not found!")
            }
        case 8:
            if let filepath = Bundle.main.path(forResource: "OFL-kalam", ofType: "txt") {
                do {
                    let licenseScript = try String(contentsOfFile: filepath)
                    self.content.text = licenseScript
                } catch {}
            } else {
                print("file not found!")
            }
        case 9:
            if let filepath = Bundle.main.path(forResource: "OFL-petit", ofType: "txt") {
                do {
                    let licenseScript = try String(contentsOfFile: filepath)
                    self.content.text = licenseScript
                } catch {}
            } else {
                print("file not found!")
            }
        case 10:
            if let filepath = Bundle.main.path(forResource: "OFL-sacra", ofType: "txt") {
                do {
                    let licenseScript = try String(contentsOfFile: filepath)
                    self.content.text = licenseScript
                } catch {}
            } else {
                print("file not found!")
            }
        default:
            if let filepath = Bundle.main.path(forResource: "OFL-nanum", ofType: "txt") {
                do {
                    let licenseScript = try String(contentsOfFile: filepath)
                    self.content.text = licenseScript
                } catch {}
            } else {
                print("file not found!")
            }
        }
        // Do any additional setup after loading the view.
//        content.text = Shared.shared.fontLicense
//        if let filepath = Bundle.main.path(forResource: "OFL-Pinyon", ofType: "txt") {
//            do {
//                let licenseScript = try String(contentsOfFile: filepath)
//                self.content.text = licenseScript
//            } catch {}
//        } else {
//            print("file not found!")
//        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
        
}

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
        // Do any additional setup after loading the view.
        if let filepath = Bundle.main.path(forResource: "OFL-Pinyon", ofType: "txt") {
            do {
                let licenseScript = try String(contentsOfFile: filepath)
                self.content.text = licenseScript
            } catch {}
        } else {
            print("file not found!")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "license" {
//            if let vc = segue.destination as? PopOverViewController {
//                vc.onChange = { font in
//                    switch font {
//                    case "Pinyon Script":
//                        if let filepath = Bundle.main.path(forResource: "OFL-Pinyon", ofType: "txt") {
//                            do {
//                                let licenseScript = try String(contentsOfFile: filepath)
//                                self.content.text = licenseScript
//                            } catch {}
//                        }
//                        else {
//                            print("file not found!")
//                        }
//                    case "Allan":
//                        if let filepath = Bundle.main.path(forResource: "OFL-Allan", ofType: "txt") {
//                            do {
//                                let licenseScript = try String(contentsOfFile: filepath)
//                                self.content.text = licenseScript
//                            } catch {}
//                        }
//                        else {
//                            print("file not found!")
//                        }
//                    case "Shadows Into Light Two":
//                        if let filepath = Bundle.main.path(forResource: "OFL-Shadow", ofType: "txt") {
//                            do {
//                                let licenseScript = try String(contentsOfFile: filepath)
//                                self.content.text = licenseScript
//                            } catch {}
//                        }
//                        else {
//                            print("file not found!")
//                        }
//                    default:
//                        print("label not found")
//                    }
//                }
//            }
//        }
        
//    }
}

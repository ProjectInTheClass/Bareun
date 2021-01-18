//
//  FontLicenseViewController.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/16.
//

import UIKit

class FontLicenseViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    var licenseText: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(licenseText)
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

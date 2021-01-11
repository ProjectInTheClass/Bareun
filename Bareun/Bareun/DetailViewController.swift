//
//  DetailViewController.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/07.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    var menu:MenuItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = menu?.name
        if titleLabel.text == "쓸모있는 영어 문장" {
            backgroundImg.image = UIImage(named: "backgroundeng.png")
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

}

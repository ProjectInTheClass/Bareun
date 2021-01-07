//
//  CoffeeDetailViewController.swift
//  DynamicTableView
//
//  Created by 이승민 on 2021/01/07.
//

import UIKit

class CoffeeDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    // Swift Optional
    var menu:MenuItem? = nil
//    var menu:Optional<MenuItem> = nil // 똑같은 표현임
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        price.text = "\(menu?.price)" // optional 변수에서만 쓸수있는 문법.. 안에 있는 메뉴아이템이라는 타입에 접근 가능
        name.text = menu?.name
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

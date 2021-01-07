//
//  CoffeeDetailViewController.swift
//  DynamicTableView
//
//  Created by YangYujin on 2021/01/07.
//

import UIKit

class CoffeeDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    // Swift Optional
    var menu: Optional<MenuItem> = nil // type 뒤에 ? -> Optional 일종의 타입 데이타가 있을 수도 있고 없을 수도 있다.
    // var menu: MenuItem? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        price.text = "\(menu?.price ?? 0)"
        name.text = menu?.name
        // menu에는 nil도 존재하기때문에 ? 붙여줘야함 엥
        
        // Do any additional setup after loading the view.
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

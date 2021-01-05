//
//  ViewController.swift
//  TableViewEx
//
//  Created by 이승민 on 2021/01/04.
//

import UIKit

struct MenuItem {
    var name:String
    var image:String
}

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItem", for: indexPath)
//        cell.textLabel?.text = fontInfo[indexPath.row].name
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomItem", for: indexPath) as! CustomItem
        let menu = items[indexPath.row]
        cell.TextLabel.text = menu.name
        cell.imageLabel.image = UIImage(named: menu.image)
        
        return cell
    }

//    let fontInfo = [
//        Font(name: "산돌구름체"),
//        Font(name: "애플고딕"),
//        Font(name: "나눔고딕"),
//        Font(name: "DX시인과나"),
//    ]
    var items:[MenuItem] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        MENU.shared.getMenuItems(completion: { menu in
            self.items = menu
            self.tableView.reloadData()
        })
    }


}


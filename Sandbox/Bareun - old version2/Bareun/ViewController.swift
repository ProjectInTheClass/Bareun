//
//  ViewController.swift
//  TableViewEx
//
//  Created by 이승민 on 2021/01/04.
//
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomItem", for: indexPath) as! CustomItem
        let menu = items[indexPath.row]
        cell.TextLabel.text = menu.name
        cell.imageLabel.image = UIImage(named: menu.image)
        
        return cell
    }

    var items:[MenuItem] = []
    @IBOutlet weak var tableView: UITableView!
    @IBAction func unwindFromVC3(segue:UIStoryboardSegue) {}
    @IBAction func unwindFromSettingVC(segue:UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        MENU.shared.getMenuItems(completion: { menu in
            self.items = menu
            self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetail" {
            let vc = segue.destination as! DetailViewController
            vc.menu = sender as! MenuItem
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.items[indexPath.row])
        performSegue(withIdentifier: "itemDetail", sender: self.items[indexPath.row])
    }
}

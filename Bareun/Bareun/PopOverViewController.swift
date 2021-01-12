//
//  PopOverViewController.swift
//  Bareun
//
//  Created by YangYujin on 2021/01/13.
//

import UIKit
 
class PopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var Popupview: UIView!
    
    @IBOutlet weak var tableView: UITableView!
        
    var names: [String] = ["나눔명조","나눔바른펜","바른히피"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
     
       // Apply radius to Popupview
        Popupview.layer.cornerRadius = 10
        Popupview.layer.masksToBounds = true
 
    }
    
    
    // Returns count of items in tableView
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count;
    }
    
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Font Name : " + names[indexPath.row])
      
         Shared.shared.FontName = names[indexPath.row]
 
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
       self.present(newViewController, animated: true, completion: nil)
  
    }
    
    //Assign values for tableView
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)

        cell.textLabel?.text = names[indexPath.row]

        return cell
    }
    

}

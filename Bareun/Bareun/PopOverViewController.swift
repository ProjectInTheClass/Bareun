//
//  PopOverViewController.swift
//  Bareun
//
//  Created by YangYujin on 2021/01/13.
//

import UIKit

struct FontInfo {
    var fontName: String
    var fileName:String
}

class PopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var Popupview: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindFromVC5(segue:UIStoryboardSegue) {}
        
    var onChange: ((String) -> Void)? = nil

    var fontItems: [FontInfo] = []
    let customColor : UIColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = customColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44
     
       // Apply radius to Popupview
        Popupview.layer.cornerRadius = 5
        Popupview.layer.masksToBounds = true
        
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.preferredContentSize = tableView.contentSize
    }
    
    // Returns count of items in tableView
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontItems.count
    }
    
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Font name : " + fontItems[indexPath.row].fontName)
        Shared.shared.FontName = fontItems[indexPath.row].fontName
        self.onChange?(Shared.shared.FontName)
        self.dismiss(animated: true)
        
    }
    
    //Assign values for tableView
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath) as! FontSelectView
        let menu = fontItems[indexPath.row]
        cell.fontName.text = menu.fontName
        cell.fontName.font = UIFont(name: menu.fileName, size: 18)
       
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        MENU.shared.getFontItems(completion: { menu in
            self.fontItems = menu
            self.tableView.reloadData()
            
            tableView.removeObserver(self, forKeyPath: "contentSize")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "license" {
            if let index = sender as? Int {
                Shared.shared.licenseIndex = index
            }
        }
    }
 

}

extension PopOverViewController: ComponentProductCellDelegate {
    func selectedInfoButton(index: Int) {
        self.performSegue(withIdentifier: "license", sender: index)
    }
}

//
//  PopOverViewController.swift
//  Bareun
//
//  Created by YangYujin on 2021/01/13.
//

import UIKit

struct FontInfo {
    var fontName: String
    var infoHidden: Bool
}

class PopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var Popupview: UIView!
    
    @IBOutlet weak var tableView: UITableView!
        
    var onChange: ((String) -> Void)? = nil
//    var onChange: (([FontInfo]) -> Void)? = nil
    var fontItems: [FontInfo] = []
    
//    var names: [String] = ["나눔명조","나눔바른펜","바른히피"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
     
       // Apply radius to Popupview
        Popupview.layer.cornerRadius = 5
        Popupview.layer.masksToBounds = true
        
    }
    
    
    // Returns count of items in tableView
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontItems.count
//        return self.names.count;
    }
    
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print("Font Name : " + names[indexPath.row])
//        Shared.shared.FontName = names[indexPath.row]
//        let FName: String = Shared.shared.FontName
        
//        switch FName {
//        case "나눔명조":
//            Shared.shared.TextImageName = "c1_01_mj"
//        case "나눔바른펜":
//            Shared.shared.TextImageName = "c1_01_bp"
//        case "바른히피":
//            Shared.shared.TextImageName = "c1_01_bh"
//        default:
//            Shared.shared.TextImageName = "c1_01_mj"
//        }
        print("Font name : " + fontItems[indexPath.row].fontName)
//        MENU.shared.fontItems = fontItems
        Shared.shared.FontName = fontItems[indexPath.row].fontName
//        self.onChange?(Shared.shared.TextImageName)
        self.onChange?(Shared.shared.FontName)
//        self.onChange?(MENU.shared.fontItems)
        self.dismiss(animated: true)
        
    }
    
    //Assign values for tableView
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath) as! FontSelectView
        let menu = fontItems[indexPath.row]
        cell.fontName.text = menu.fontName
        cell.infoButton.isHidden = menu.infoHidden
//        cell.textLabel?.text = names[indexPath.row]

        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        MENU.shared.getFontItems(completion: { menu in
            self.fontItems = menu
            self.tableView.reloadData()
        })
    }

}

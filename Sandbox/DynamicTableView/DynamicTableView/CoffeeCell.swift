//
//  CoffeeCell.swift
//  DynamicTableView
//
//  Created by KANG HEE JONG on 2021/01/05.
//

import UIKit

class CoffeeCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var menuName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

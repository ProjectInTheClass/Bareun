//
//  CustomItem.swift
//  TableViewEx
//
//  Created by 이승민 on 2021/01/05.
//

import UIKit

class CustomItem: UITableViewCell {

    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

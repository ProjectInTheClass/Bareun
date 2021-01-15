//
//  FontSelectView.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/12.
//

import UIKit

class FontSelectView: UITableViewCell {

    @IBOutlet weak var fontName: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

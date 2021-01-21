//
//  FontSelectView.swift
//  Bareun
//
//  Created by 이승민 on 2021/01/12.
//

import UIKit

protocol ComponentProductCellDelegate {
    func selectedInfoButton(index: Int)
}

class FontSelectView: UITableViewCell {

    @IBOutlet weak var fontName: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    var index: Int = 0
    var delegate: ComponentProductCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectedInfoButton(_ sender: Any) {
        self.delegate?.selectedInfoButton(index: index)
    }
    
}

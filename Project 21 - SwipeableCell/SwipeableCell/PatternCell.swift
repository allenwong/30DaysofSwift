//
//  PatternCell.swift
//  SwipeableCell
//
//  Created by Allen on 16/1/28.
//  Copyright © 2016年 AppKitchen. All rights reserved.
//

import UIKit

struct pattern {
    let image: String
    let name: String
}

class PatternCell: UITableViewCell {

    @IBOutlet weak var patternNameLabel: UILabel!
    @IBOutlet weak var patternImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

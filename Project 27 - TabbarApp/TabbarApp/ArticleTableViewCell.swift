//
//  ArticleTableViewCell.swift
//  TabbarApp
//
//  Created by Allen on 16/2/5.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

struct article {
    let avatarImage: String
    let sharedName: String
    let actionType: String
    let articleTitle: String
    let articleCoverImage: String
    let articleSouce: String
    let articleTime: String
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var sharedNameLabel: UILabel!
    @IBOutlet weak var actionTypeLabel: UILabel!
    @IBOutlet weak var articleCoverImage: UIImageView!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleSouceLabel: UILabel!
    @IBOutlet weak var articelCreatedAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

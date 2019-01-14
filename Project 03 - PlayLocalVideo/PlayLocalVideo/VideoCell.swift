//
//  VideoCell.swift
//  PlayLocalVideo
//
//  Created by Allen on 16/1/10.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

// 定义Video的结构体，属性初始化后不能被改变，因为结构体时值类型。
// 在你每次定义一个新类或者结构体的时候，实际上你是定义了一个新的 Swift 类型。
// 因此请使用UpperCamelCase这种方式来命名
struct Video {
    let image: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoScreenshot: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoSourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

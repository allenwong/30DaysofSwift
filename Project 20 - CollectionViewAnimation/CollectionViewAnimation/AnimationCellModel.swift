//
//  AnimationCellModel.swift
//  CollectionViewAnimation
//
//  Created by Patrick Reynolds on 2/15/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import Foundation

struct AnimationCellModel {
    let imagePath: String
    
    init(imagePath: String?) {
        self.imagePath = imagePath ?? ""
    }
}

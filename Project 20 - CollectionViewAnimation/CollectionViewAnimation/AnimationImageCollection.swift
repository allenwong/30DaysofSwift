//
//  AnimationImageCollection.swift
//  CollectionViewAnimation
//
//  Created by Patrick Reynolds on 2/15/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

struct AnimationImageCollection {
    private let imagePaths = ["1", "2", "3", "4", "5"]
    var images: [AnimationCellModel]
    
    init() {
        images = imagePaths.map { AnimationCellModel(imagePath: $0) }
    }
}

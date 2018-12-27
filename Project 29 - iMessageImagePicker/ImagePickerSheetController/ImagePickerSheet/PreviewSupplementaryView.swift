//
//  PreviewSupplementaryView.swift
//  ImagePickerSheet
//
//  Created by Laurin Brandner on 06/09/14.
//  Copyright (c) 2014 Laurin Brandner. All rights reserved.
//

import UIKit

class PreviewSupplementaryView : UICollectionReusableView {
    
    private let button: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.isUserInteractionEnabled = false
        button.setImage(PreviewSupplementaryView.checkmarkImage, for: .normal)
        button.setImage(PreviewSupplementaryView.selectedCheckmarkImage, for: .selected)
        
        return button
    }()
    
    var buttonInset = UIEdgeInsets.zero
    
    var selected: Bool = false {
        didSet {
            button.isSelected = selected
            reloadButtonBackgroundColor()
        }
    }
    
    class var checkmarkImage: UIImage? {
        let bundle = Bundle(for: ImagePickerSheetController.self)
        let image = UIImage(named: "PreviewSupplementaryView-Checkmark", in: bundle, compatibleWith: nil)
        
        return image?.withRenderingMode(.alwaysTemplate)
    }
    
    class var selectedCheckmarkImage: UIImage? {
        let bundle = Bundle(for: ImagePickerSheetController.self)
        let image = UIImage(named: "PreviewSupplementaryView-Checkmark-Selected", in: bundle, compatibleWith: nil)
        
        return image?.withRenderingMode(.alwaysTemplate)
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        initialize()
    }
    
    private func initialize() {
        addSubview(button)
    }
    
    // MARK: - Other Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        selected = false
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
        reloadButtonBackgroundColor()
    }
    
    private func reloadButtonBackgroundColor() {
        button.backgroundColor = (selected) ? tintColor : nil
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.sizeToFit()
        button.frame.origin = CGPoint(x: buttonInset.left, y: bounds.height-button.frame.height-buttonInset.bottom)
        button.layer.cornerRadius = button.frame.height / 2.0
    }
    
}

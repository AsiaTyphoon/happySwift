//
//  AutoListOneCollectionViewCell.swift
//  happySwift
//
//  Created by dfsx6 on 2021/7/16.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit

class AutoListOneCollectionViewCell: UICollectionViewCell, DSNibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var bgWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
//    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        
//    }
//    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
//        
//        let size = self.contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var cellFrame = layoutAttributes.frame
//        cellFrame.origin.x = 50
//        cellFrame.origin.y = 0
//        cellFrame.size.width = size.width
//        cellFrame.size.height = size.height
//        layoutAttributes.frame = cellFrame
//        return layoutAttributes
//
//    }
}



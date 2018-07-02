//
//  HSCollectionViewCell.swift
//  happySwift
//
//  Created by dfsx1 on 2018/7/2.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

class HSCollectionViewCell: UICollectionViewCell {
    
    var labelTitle: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        labelTitle.backgroundColor = UIColor.lightGray
        self.addSubview(labelTitle)
    }
    
    override func layoutSubviews() {
        let lw = self.frame.size.width
        let lh = self.frame.size.height
        
        labelTitle.frame = CGRect(x: 0, y: 0, width: lw, height: lh)
        labelTitle.clipsToBounds = true
        labelTitle.layer.cornerRadius = 5
    }
    
}

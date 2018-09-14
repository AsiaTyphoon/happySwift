//
//  HSCollectionViewCell.swift
//  happySwift
//
//  Created by dfsx1 on 2018/7/2.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit
import SnapKit

class HSCollectionViewCell: UICollectionViewCell {
    
    var labelTitle: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        clipsToBounds = true
        layer.cornerRadius = 5
        labelTitle.textAlignment = .center
        self.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.left.top.equalTo(5)
            make.right.bottom.equalTo(-5)
        }
        
    }
    
}

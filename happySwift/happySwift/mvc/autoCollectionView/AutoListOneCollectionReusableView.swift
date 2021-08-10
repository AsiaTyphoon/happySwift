//
//  AutoListOneCollectionReusableView.swift
//  happySwift
//
//  Created by dfsx6 on 2021/8/3.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit

class AutoListOneCollectionReusableView: UICollectionReusableView, DSNibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.backgroundColor = .orange
    }
    
}

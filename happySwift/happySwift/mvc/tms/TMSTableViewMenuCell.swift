//
//  TMSTableViewMenuCell.swift
//  happySwift
//
//  Created by dfsx6 on 2021/5/24.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit

class TMSTableViewMenuCell: UITableViewCell, DSNibReusable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgViewHeight: NSLayoutConstraint!
    
    
    public let menuVC = MenuPageViewController.init()
    let firstVC = HomeViewController.init()
    let secondVC = HomeViewController.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        firstVC.title = "first"
        secondVC.title = "second"
        bgView.addSubview(menuVC.view)
        menuVC.reload(for: [firstVC, secondVC])
        bgViewHeight.constant = 500
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        menuVC.view.frame = bgView.bounds
    }
    
}

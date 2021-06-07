//
//  TMSViewController.swift
//  happySwift
//
//  Created by dfsx6 on 2021/5/24.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit

class TMSViewController: BaseViewController {

    fileprivate let myModel = TMSTableView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(myModel.tableView)
        myModel.requestData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myModel.tableView.frame = CGRect.init(x: 0, y: safeAreaNavigationBar, width: view.frame.width, height: view.frame.height - safeAreaNavigationBar)
    }

}


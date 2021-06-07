//
//  HomeViewController.swift
//  happySwift
//
//  Created by ianin on 2020/4/13.
//  Copyright © 2020 slardar. All rights reserved.
//

import UIKit

//MARK:-
class HomeViewController: BaseViewController {

    fileprivate let myModel = HomeTableView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.backBtn.isHidden = true
        
        view.addSubview(myModel.tableView)
        myModel.requestData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myModel.tableView.frame = CGRect.init(x: 0, y: safeAreaNavigationBar, width: view.frame.width, height: view.frame.height - safeAreaNavigationBar)
    }

}


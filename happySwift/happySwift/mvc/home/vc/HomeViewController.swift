//
//  HomeViewController.swift
//  happySwift
//
//  Created by ianin on 2020/4/13.
//  Copyright © 2020 slardar. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    fileprivate var myViewModel = sss.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 使用数据来驱动UI
        
        view.addSubview(myViewModel.collectionView)
        myViewModel.collectionView.frame = view.bounds
        myViewModel.collectionView.backgroundColor = .white
        
        myViewModel.refreshData(showLoading: false)
    }
    

}


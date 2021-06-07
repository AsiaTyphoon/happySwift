//
//  BaseViewController.swift
//  happySwift
//
//  Created by ianin on 2020/4/13.
//  Copyright © 2020 slardar. All rights reserved.
//

import UIKit

//MARK:-
open class BaseViewController: UIViewController {
    
    open override var title: String? {
        didSet {
            self.navigationBar.titleLabel.text = title
        }
    }
    
    public let navigationBar = BaseNavigationBar.loadMyNib()!
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: safeAreaNavigationBar)
        navigationBar.backBtn.addTarget(self, action: #selector(clickBackAction(_:)), for: .touchUpInside)
        view.addSubview(navigationBar)
        
    }
    
    
    open func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print(NSStringFromClass(self.classForCoder), #function)
    }
}

//MARK:-
extension BaseViewController {
    ///
    @objc fileprivate func clickBackAction(_ sender: Any?) {
        backAction()
    }
}

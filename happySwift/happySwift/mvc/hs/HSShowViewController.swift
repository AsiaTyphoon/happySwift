//
//  HSShowViewController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/7/3.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

//MARK:-
class HSShowViewController: BaseViewController {

    var fileUrl: URL?
    fileprivate let textView = UITextView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(textView)
        
        guard let g_fileUrl = fileUrl else {
            return
        }
        
        do {
            let g_data = try Data.init(contentsOf: g_fileUrl)
            let str = String.init(data: g_data, encoding: .utf8)
            textView.text = str
        } catch {
            print("init_data_error:\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("----- deinit ----- \(self.classForCoder)")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = CGRect.init(x: 0, y: safeAreaNavigationBar, width: view.frame.width, height: view.frame.height - safeAreaNavigationBar - safeAreaInsetsBottom)
    }
}

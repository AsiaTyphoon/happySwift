//
//  HSShowViewController.swift
//  happySwift
//
//  Created by dfsx1 on 2018/7/3.
//  Copyright © 2018年 slardar. All rights reserved.
//

import UIKit

class HSShowViewController: UIViewController {

    var fileUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let textView = UITextView(frame: self.view.frame)
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
        print("-----deinit-----\(self.classForCoder)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

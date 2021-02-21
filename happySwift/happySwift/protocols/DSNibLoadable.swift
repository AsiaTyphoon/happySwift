//
//  DSNibLoadable.swift
//  DSKit
//
//  Created by dfsx6 on 2020/5/27.
//  Copyright © 2020 成都东方盛行电子有限责任公司. All rights reserved.
//

import UIKit

//MARK:- 
public protocol DSNibLoadable: class {
    
    static var myNib: UINib? { get }
}

//MARK:-
public extension DSNibLoadable {
    static var myNib: UINib? {
        // 判断是否有对应的nib文件
        let bundle = Bundle.init(for: self)
        let nibName = String.init(describing: self)
        guard let _ = bundle.path(forResource: nibName, ofType: "nib") else {
            print("没有对应的nib文件：\(nibName)")
            return nil
        }
        return UINib.init(nibName: nibName, bundle: bundle)
    }
}


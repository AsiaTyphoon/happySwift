//
//  DSNibLoadable+UIView.swift
//  DSKit
//
//  Created by dfsx6 on 2020/5/27.
//  Copyright © 2020 成都东方盛行电子有限责任公司. All rights reserved.
//

import UIKit

//MARK:-
public extension DSNibLoadable where Self: UIView {
    
    /// 根据类名加载xib
    static func loadMyNib() -> Self? {
        guard let nib = myNib else { return nil }
        guard let first = nib.instantiate(withOwner: nil, options: nil).first else {
            print("nib文件为空: \(String.init(describing: self))")
            return nil
        }
        guard let nibView = first as? Self else {
            print("nib文件关联错误: \(String.init(describing: self)) \nnib: \(String.init(describing: first))")
            return nil
        }
        return nibView
    }
}

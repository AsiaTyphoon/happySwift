//
//  DSReusable.swift
//  DSKit
//
//  Created by dfsx6 on 2020/5/27.
//  Copyright © 2020 成都东方盛行电子有限责任公司. All rights reserved.
//

import UIKit

//MARK:-
public protocol DSReusable: class {
    /// 复用id
    static var reuseID: String { get }
}

//MARK:-
public extension DSReusable {
    
    static var reuseID: String {
        return String(describing: self)
    }
}

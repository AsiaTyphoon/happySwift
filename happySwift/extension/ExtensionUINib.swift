//
//  ExtensionUINib.swift
//  happySwift
//
//  Created by dfsx1 on 2019/4/1.
//  Copyright © 2019 slardar. All rights reserved.
//

import Foundation
import UIKit

public protocol UINibloadable {
    
}

/// 根据类名加载xib
/// - parameter  :
/// - returns :
public extension UINibloadable where Self: UIView {
    
    static public func loadNib() -> Self? {
        
        // 当前Bundle
        let currentBundle = Bundle(for: Self.classForCoder())
        
        //FIXME: xib文件是否存在
        if let _ = currentBundle.path(forResource: "\(self)", ofType: "nib") {
            if let view = currentBundle.loadNibNamed("\(self)", owner: nil, options: nil)?.first as? Self {
                return view
            }
        }
        
        return nil
    }
}

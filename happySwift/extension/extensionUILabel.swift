//
//  extensionUILabel.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/14.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    
    /// 文本在屏幕宽度内的尺寸
    /// - returns : 文本尺寸
    func textSize() -> CGSize {
        guard let str = self.text else {
            return .zero
        }
        let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        return str.size(size, self.font ?? UIFont.systemFont(ofSize: 14))
    }
}

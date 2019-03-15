//
//  VMUnit.swift
//  happySwift
//
//  Created by dfsx1 on 2019/2/26.
//  Copyright © 2019 slardar. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol VMCellDataSource: NSObjectProtocol {
    
    func setDataSource(_ sender: Any?, _ dataSource: Any?)
    @objc optional func didSelected(_ sender: Any?, _ dataSource: Any?)
}


open class VMObject: NSObject {
    
    open var item: AnyClass = UICollectionViewCell.classForCoder()
    open var itemSize: CGSize = .zero
    open var reuseID = "UICollectionViewCellID"
    open var title: String?
    
    override public init() {
        super.init()
    }
    
}

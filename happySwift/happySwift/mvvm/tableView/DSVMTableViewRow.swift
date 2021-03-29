//
//  DSVMTableViewRow.swift
//  core
//
//  Created by dfsx6 on 2020/11/6.
//  Copyright © 2020 jianglin. All rights reserved.
//

import Foundation

//MARK:-
open class DSVMTableViewRow<T>: NSObject {
        
    public var item: T!
    public convenience init(item: T) {
        self.init()
        self.item = item
    }
    
    public var cell: UITableViewCell! = UITableViewCell.init()
    public var indexPath: IndexPath! = IndexPath.init()
    public var tableView: UITableView? = nil
    
    public var didSelectRowClosure: ((IndexPath) -> Void)?
}

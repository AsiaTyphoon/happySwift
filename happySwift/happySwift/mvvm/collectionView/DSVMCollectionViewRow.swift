//
//  DSVMCollectionViewRow.swift
//  core
//
//  Created by dfsx6 on 2020/10/16.
//  Copyright © 2020 jianglin. All rights reserved.
//

import Foundation

//MARK:-
open class DSVMCollectionViewRow<T>: NSObject {
        
    public var item: T!
    public convenience init(item: T) {
        self.init()
        self.item = item
    }
    
    public var cell: UICollectionViewCell! = UICollectionViewCell.init()
    public var indexPath: IndexPath! = IndexPath.init()
    public var collectionView: UICollectionView? = nil
    
    public var didSelectRowClosure: ((IndexPath) -> Void)?
}


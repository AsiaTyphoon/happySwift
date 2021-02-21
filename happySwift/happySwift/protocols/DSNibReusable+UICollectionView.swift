//
//  DSNibReusable+UICollectionView.swift
//  DSKit
//
//  Created by dfsx6 on 2020/5/27.
//  Copyright © 2020 成都东方盛行电子有限责任公司. All rights reserved.
//

import UIKit

//MARK:-
public extension UICollectionView {
    
    /// 使用cell名称做复用ID注册
    func exRegister<T: UICollectionViewCell>(cell: T.Type)
        where T: DSReusable {
            self.register(cell.self, forCellWithReuseIdentifier: cell.reuseID)
    }
    
    /// 使用cell名称做复用ID注册UINib
    func exRegister<T: UICollectionViewCell>(cell: T.Type)
        where T: DSNibReusable {
            self.register(cell.myNib, forCellWithReuseIdentifier: cell.reuseID)
    }
    
    
    /// 获取复用cell
    func exDequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T?
        where T: DSReusable {
            let reuseCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath)
            guard let cell = reuseCell as? T else {
                return nil
            }
            return cell
    }
    
}


//MARK:-
public extension UICollectionView {
    
    /// 注册顶、底部视图
    func exRegister<T: UICollectionReusableView>(supplementaryView: T.Type, ofKind elementKind: String)
        where T: DSReusable {
            self.register(
                supplementaryView.self,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryView.reuseID
            )
    }
    
    /// 注册顶、底部视图
    func exRegister<T: UICollectionReusableView>(supplementaryView: T.Type, ofKind elementKind: String)
        where T: DSNibReusable {
            self.register(
                supplementaryView.myNib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryView.reuseID
            )
    }
    
    
    /// 获取复用顶、底部视图
    func exDequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T?
        where T: DSReusable {
            let reuseView = self.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: viewType.reuseID,
                for: indexPath
            )
            guard let view = reuseView as? T else {
                return nil
            }
            return view
    }
    
}


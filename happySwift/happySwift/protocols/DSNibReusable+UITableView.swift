//
//  DSNibReusable+UITableView.swift
//  DSKit
//
//  Created by dfsx6 on 2020/5/27.
//  Copyright © 2020 成都东方盛行电子有限责任公司. All rights reserved.
//

import UIKit

//MARK:-
public extension UITableView {
    
    /// 注册cell
    func exRegister<T: UITableViewCell>(cell: T.Type)
      where T: DSReusable {
        self.register(cell.self, forCellReuseIdentifier: cell.reuseID)
    }
  
    /// 注册cell
    func exRegister<T: UITableViewCell>(cell: T.Type)
      where T: DSNibReusable {
        self.register(cell.myNib, forCellReuseIdentifier: cell.reuseID)
    }
    

    /// 获取复用cell
    func exDequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T?
      where T: DSReusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseID, for: indexPath) as? T else {
          return nil
        }
        return cell
    }
  
    /// 获取复用cell 不按索引
      func exDequeueReusableCell<T: UITableViewCell>( cellType: T.Type = T.self) -> T?
        where T: DSReusable {
          guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseID) as? T else {
            return nil
          }
          return cell
      }
    /// 注册顶、底部视图
    func exRegister<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
      where T: DSReusable {
        self.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseID)
    }
    
    /// 注册顶、底部视图
    func exRegister<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
      where T: DSNibReusable {
        self.register(headerFooterViewType.myNib, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseID)
    }
  
    /// 获取复用视图
    func exDequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T?
      where T: DSReusable {
        let reuseView = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseID)
        guard let view = reuseView as? T? else {
          return nil
        }
        return view
    }
}

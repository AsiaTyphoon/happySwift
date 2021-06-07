//
//  TMSTableViewMenu.swift
//  happySwift
//
//  Created by dfsx6 on 2021/5/24.
//  Copyright © 2021 slardar. All rights reserved.
//

import Foundation
import UIKit

class TMSTableViewMenu: NSObject {
    
    var cell: UITableViewCell! = UITableViewCell.init()
    var indexPath: IndexPath! = IndexPath.init()
    var tableView: UITableView? = nil
    
}

//MARK:-
extension TMSTableViewMenu: DSVMTableViewRowProtocol {
    
    func registCell(for tableView: UITableView) {
        tableView.exRegister(cell: TMSTableViewMenuCell.self)
    }
    
    func dequeueReusableCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.exDequeueReusableCell(for: indexPath, cellType: TMSTableViewMenuCell.self) else {
            return UITableViewCell.init()
        }
        return cell
    }
    
    func heightForRow(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func didSelectRow(for tableView: UITableView, at indexPath: IndexPath) {
        
    }
    
    
}

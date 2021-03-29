//
//  DSVMTableViewRowProtocol.swift
//  core
//
//  Created by dfsx6 on 2020/11/6.
//  Copyright © 2020 jianglin. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public protocol DSVMTableViewRowProtocol: NSObjectProtocol {
            
    var cell: UITableViewCell! { get set }
    var indexPath: IndexPath! { get set }
    var tableView: UITableView? { get set }

    func registCell(for tableView: UITableView)
    func dequeueReusableCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func heightForRow(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat
    func didSelectRow(for tableView: UITableView, at indexPath: IndexPath)
}

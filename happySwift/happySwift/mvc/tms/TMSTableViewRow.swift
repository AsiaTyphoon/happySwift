//
//  TMSTableViewRow.swift
//  happySwift
//
//  Created by dfsx6 on 2021/5/24.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit

class TMSTableViewRow: NSObject {
    
    var cell: UITableViewCell! = UITableViewCell.init()
    var indexPath: IndexPath! = IndexPath.init()
    var tableView: UITableView? = nil
    
}

//MARK:-
extension TMSTableViewRow: DSVMTableViewRowProtocol {
    
    func registCell(for tableView: UITableView) {
        tableView.exRegister(cell: HomeTableViewListCell.self)
    }
    
    func dequeueReusableCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.exDequeueReusableCell(for: indexPath, cellType: HomeTableViewListCell.self) else {
            return UITableViewCell.init()
        }
        cell.textLabel?.text = "menu"
        return cell
    }
    
    func heightForRow(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func didSelectRow(for tableView: UITableView, at indexPath: IndexPath) {
        let targetVC = TMSViewController.init()
        targetVC.title = "menu"
        exTopVC()?.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
}

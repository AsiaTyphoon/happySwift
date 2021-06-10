//
//  NestedListViewController.swift
//  happySwift
//
//  Created by dfsx6 on 2021/6/10.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit
import JXSegmentedView

class NestedListViewController: UITableViewController {

    public var lastOffsetY: CGFloat = 0
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .purple
        cell.textLabel?.text = String(describing: indexPath.row)
        return cell
    }
}

//MARK:-
extension NestedListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
    
    
}

//MARK:-
//extension NestedListViewController: DSPagingSmoothViewListViewDelegate {
//    func listScrollView() -> UIScrollView {
//        return tableView
//    }
//    
//    
//}

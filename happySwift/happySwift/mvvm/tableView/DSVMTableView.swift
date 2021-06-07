//
//  DSVMTableView.swift
//  core
//
//  Created by dfsx6 on 2020/11/6.
//  Copyright © 2020 jianglin. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

//MARK:-
open class DSVMTableView: NSObject {
    
    public var pageIndex: Int = 1   // 数据翻页页码
    public var pageSize: Int = 20   // 数据翻页数量
    fileprivate var rowArr: [DSVMTableViewRowProtocol] = []
    
    ///
    public private(set) lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.mj_header = self.refreshHeader
        tableView.mj_footer = self.refreshFooter
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    /// 下拉刷新
    public private(set) lazy var refreshHeader: MJRefreshNormalHeader = {
        let refreshHeader = MJRefreshNormalHeader.init()
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(refreshAction))
        refreshHeader.lastUpdatedTimeLabel.isHidden = true
        refreshHeader.stateLabel.isHidden = true
        return refreshHeader
    }()

    /// 上拉加载更多
    fileprivate lazy var refreshFooter: MJRefreshAutoNormalFooter = {
        let refreshFooter = MJRefreshAutoNormalFooter()
        refreshFooter.setRefreshingTarget(self, refreshingAction: #selector(loadMoreAction))
        refreshFooter.setTitle("上拉加载", for: .idle)
        refreshFooter.setTitle("数据加载完毕", for: .noMoreData)
        refreshFooter.isHidden = true
        return refreshFooter
    }()
    
    
    //MARK:- init
    public override init() {
        super.init()
    }
    
    deinit {
        print(NSStringFromClass(self.classForCoder), #function)
    }
    
        
    //MARK:- for override
    //MARK:刷新数据
    open func refreshData(success: @escaping (_ rows: [DSVMTableViewRowProtocol]) -> Void,
                          failure: @escaping (_ error: NSError) -> Void) {
        
        print("Please override this function to refresh data!", #function)
        success([])
    }
    
    /// 加载更多数据
    open func loadMoreData(success: @escaping (_ rows: [DSVMTableViewRowProtocol]) -> Void,
                           failure: @escaping (_ error: NSError) -> Void) {
        
        print("Please override this function to load more data!", #function)
        success([])
    }
    
    //MARK:空数据视图
    open func emptyDataView() -> (view: UIView, insets: UIEdgeInsets) {
        
        let newClosure: () -> UIView = {
            print("Please override this function to provide a new empty view!", #function)
            return UIView.init()
        }
        let tag: Int = 10001
        let errorView = tableView.viewWithTag(tag) as? UIView ?? newClosure()
        errorView.tag = tag
        //errorView.clickButton.setBackgroundImage(UIImage(named: "暂无内容"), for: .normal)
        return (errorView, .zero)
    }
    
    
    //MARK:网络错误视图
    open func networkErrorView() -> (view: UIView, insets: UIEdgeInsets) {
        
        let newClosure: () -> UIView = {
            print("Please override this function to provide a new network error view!", #function)
            return UIView.init()
        }
        let tag: Int = 10002
        let errorView = tableView.viewWithTag(tag) as? UIView ?? newClosure()
        errorView.tag = tag
        //errorView.clickButton.setBackgroundImage(UIImage(named: "网络错误"), for: .normal)
        //errorView.clickButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        return (errorView, .zero)
    }
    
}


//MARK:-
extension DSVMTableView {
    
    ///
    public func requestData(showLoading: Bool = true) {
        if showLoading {
            self.refreshHeader.beginRefreshing()
        } else {
            self.refreshAction()
        }
    }
    
    ///
    public func reload(with rows: [DSVMTableViewRowProtocol]) {
        rows.forEach { (row) in
            row.registCell(for: tableView)
        }
        rowArr = rows
        tableView.reloadData()
        self.showDataEmptyView(rows.count == 0)
    }
    
    ///
    fileprivate func loadMore(with rows: [DSVMTableViewRowProtocol]) {
        rows.forEach { (row) in
            row.registCell(for: tableView)
        }
        rowArr += rows
        tableView.reloadData()
    }

    ///
    @objc fileprivate func refreshAction() {
        if self.refreshHeader.isHidden {
            // 隐藏刷新控件后，contentSize异常
            self.tableView.contentInset = .zero
        }
        self.pageIndex = 1
        self.refreshFooter.isHidden = true
        self.refreshFooter.resetNoMoreData()
        self.showDataEmptyView(false)
        self.showNetworkErrorView(false)
        self.refreshData(success: { [weak self] (rows) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.refreshHeader.endRefreshing()
                self.refreshFooter.isHidden = (rows.count == 0)
                if rows.count < self.pageSize {
                    self.refreshFooter.endRefreshingWithNoMoreData()
                }
                self.reload(with: rows)
            }
        }) { [weak self] (error) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.refreshHeader.endRefreshing()
                self.showNetworkErrorView(true)
            }
        }
    }
    
    ///
    @objc fileprivate func loadMoreAction() {
        
        self.pageIndex += 1
        
        self.loadMoreData(success: { [weak self] (rows) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if rows.count == 0 {
                    self.refreshFooter.endRefreshingWithNoMoreData()
                    self.pageIndex -= 1
                } else {
                    self.refreshFooter.endRefreshing()
                    self.loadMore(with: rows)
                }
            }
        }) { [weak self] (error) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.refreshFooter.endRefreshing()
                self.pageIndex -= 1
            }
        }
    }
    
}

//MARK:-
extension DSVMTableView {
    ///
    fileprivate func showDataEmptyView(_ show: Bool) {
        let empty = emptyDataView()
        let view = empty.view
        let insets = empty.insets
        view.isHidden = !show
        view.frame = CGRect.init(x: insets.left,
                                 y: insets.top,
                                 width: tableView.frame.width - insets.left - insets.right,
                                 height: tableView.frame.height - insets.top - insets.bottom)
        tableView.addSubview(view)
    }
    
    
    ///
    fileprivate func showNetworkErrorView(_ show: Bool) {
        let network = networkErrorView()
        let view = network.view
        let insets = network.insets
        view.isHidden = !show
        view.frame = CGRect.init(x: insets.left,
                                 y: insets.top,
                                 width: tableView.frame.width - insets.left - insets.right,
                                 height: tableView.frame.height - insets.top - insets.bottom)
        tableView.addSubview(view)
    }

}

//MARK:-
extension DSVMTableView : UITableViewDelegate, UITableViewDataSource {
    
    //MARK:UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArr.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = rowArr[indexPath.row]
        let height = item.heightForRow(for: tableView, at: indexPath)
        return height
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = rowArr[indexPath.row]
        let cell = item.dequeueReusableCell(for: tableView, at: indexPath)
        item.cell = cell
        item.tableView = tableView
        item.indexPath = indexPath
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rowArr[indexPath.row]
        item.didSelectRow(for: tableView, at: indexPath)
    }
    
}

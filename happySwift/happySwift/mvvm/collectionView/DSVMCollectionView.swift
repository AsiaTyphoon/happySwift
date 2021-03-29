//
//  DSVMCollectionView.swift
//  core
//
//  Created by dfsx6 on 2020/10/16.
//  Copyright © 2020 jianglin. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

//MARK:-
open class DSVMCollectionView: NSObject {
    
    public var pageIndex: Int = 1   // 数据翻页页码
    public var pageSize: Int = 20   // 数据翻页数量
    fileprivate var rowArr: [DSVMCollectionViewRowProtocol] = []

    ///
    public private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.mj_header = self.refreshHeader
        collectionView.mj_footer = self.refreshFooter
        return collectionView
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
    open func refreshData(success: @escaping (_ rows: [DSVMCollectionViewRowProtocol]) -> Void,
                          failure: @escaping (_ error: NSError) -> Void) {
        
        print("Please override this function to refresh data!", #function)
        success([])
    }
    
    /// 加载更多数据
    open func loadMoreData(success: @escaping (_ rows: [DSVMCollectionViewRowProtocol]) -> Void,
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
        let errorView = collectionView.viewWithTag(tag) as? UIView ?? newClosure()
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
        let errorView = collectionView.viewWithTag(tag) as? UIView ?? newClosure()
        errorView.tag = tag
        //errorView.clickButton.setBackgroundImage(UIImage(named: "网络错误"), for: .normal)
        //errorView.clickButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        return (errorView, .zero)
    }
    
}

//MARK:-
extension DSVMCollectionView {
    
    ///
    public func requestData(showLoading: Bool = true) {
        if showLoading {
            self.refreshHeader.beginRefreshing()
        } else {
            self.refreshAction()
        }
    }
    
    ///
    public func reload(with rows: [DSVMCollectionViewRowProtocol]) {
        rows.forEach { (row) in
            row.registCell(for: collectionView)
        }
        rowArr = rows
        collectionView.reloadData()
        self.showDataEmptyView(rows.count == 0)
    }
    
    ///
    fileprivate func loadMore(with rows: [DSVMCollectionViewRowProtocol]) {
        rows.forEach { (row) in
            row.registCell(for: collectionView)
        }
        rowArr += rows
        collectionView.reloadData()
    }

    ///
    @objc fileprivate func refreshAction() {
        if self.refreshHeader.isHidden {
            // 隐藏刷新控件后，contentSize异常
            self.collectionView.contentInset = .zero
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
extension DSVMCollectionView {
    ///
    fileprivate func showDataEmptyView(_ show: Bool) {
        let empty = emptyDataView()
        let view = empty.view
        let insets = empty.insets
        view.isHidden = !show
        view.frame = CGRect.init(x: insets.left,
                                 y: insets.top,
                                 width: collectionView.frame.width - insets.left - insets.right,
                                 height: collectionView.frame.height - insets.top - insets.bottom)
        collectionView.addSubview(view)
    }
    
    
    ///
    fileprivate func showNetworkErrorView(_ show: Bool) {
        let network = networkErrorView()
        let view = network.view
        let insets = network.insets
        view.isHidden = !show
        view.frame = CGRect.init(x: insets.left,
                                 y: insets.top,
                                 width: collectionView.frame.width - insets.left - insets.right,
                                 height: collectionView.frame.height - insets.top - insets.bottom)
        collectionView.addSubview(view)
    }

}

//MARK:-
extension DSVMCollectionView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK:UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowArr.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = rowArr[indexPath.row]
        let cell = item.dequeueReusableCell(for: collectionView, at: indexPath)
        item.cell = cell
        item.collectionView = collectionView
        item.indexPath = indexPath
        return cell
    }
    
    //MARK:UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = rowArr[indexPath.row]
        let size = item.sizeForRow(for: collectionView, at: indexPath)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = rowArr[indexPath.row]
        item.didSelectRow(for: collectionView, at: indexPath)
    }
    
}

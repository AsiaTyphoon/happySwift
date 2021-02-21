//
//  DSBaseCollectionViewController.swift
//  happySwift
//
//  Created by dfsx6 on 2020/9/29.
//  Copyright © 2020 slardar. All rights reserved.
//

import UIKit
import MJRefresh

//MARK:-
public protocol DSVMRowProtocol: NSObjectProtocol {
    
    func registCell(for collectionView: UICollectionView)
    func dequeueReusableCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    func sizeForItem(for collectionView: UICollectionView, at indexPath: IndexPath) -> CGSize
}


//MARK:-
public protocol DSVMSectionProtocol: NSObjectProtocol {
    func sections() -> [DSVMRowProtocol]
}

//MARK:-
public class SectionModel: NSObject, DSVMSectionProtocol {
    public func sections() -> [DSVMRowProtocol] {
        return [ListItemViewModel.init()]
    }
    
    
}

//MARK:-
open class DSVMCollection: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func refreshData(success: @escaping (_ arr: [DSVMSectionProtocol]) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            print("222222")
            success([SectionModel.init(), SectionModel.init()])
        }
    }
    
    
    public private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.mj_header = self.refreshHeader
        return collectionView
    }()
    
    
    fileprivate lazy var refreshHeader: MJRefreshNormalHeader = {
        let refreshHeader = MJRefreshNormalHeader.init()
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(refresh))
        refreshHeader.stateLabel.isHidden = true
        refreshHeader.lastUpdatedTimeLabel.isHidden = true
        return refreshHeader
    }()

    @objc fileprivate func refresh() {
        self.refreshData { [weak self] (arr) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.refreshHeader.endRefreshing()
                self.reload(with: arr)
            }
        }
    }
    
    fileprivate var dataArr: [DSVMSectionProtocol] = []
    
    public override init() {
        super.init()
        
    }
    
    public func refreshData(showLoading: Bool = true) {
        if showLoading {
            self.refreshHeader.beginRefreshing()
        } else {
            self.refresh()
        }
    }

    
    
    public func reload(with arr: [DSVMSectionProtocol]) {
        dataArr = arr
        for section in arr {
            for m in section.sections() {
                m.registCell(for: collectionView)
            }
        }
        collectionView.reloadData()
    }
    
    
    //MARK:-UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr[section].sections().count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let list = dataArr[indexPath.section]
        let m = list.sections()[indexPath.row]
        return m.dequeueReusableCell(for: collectionView, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let list = dataArr[indexPath.section]
        let m = list.sections()[indexPath.row]
        return m.sizeForItem(for: collectionView, at: indexPath)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArr.count
    }
}



//MARK:-
open class DSBaseCollectionViewController: BaseViewController {

    //fileprivate let myModel = DSVMCollection.init()
    

}

//MARK:-
extension DSBaseCollectionViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        //view.addSubview(myModel.collectionView)
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //myModel.collectionView.frame = view.bounds
    }
}

//MARK:-
extension DSBaseCollectionViewController {
    
}

//MARK:-
extension DSBaseCollectionViewController {
    
}

//MARK:-
extension DSBaseCollectionViewController {
    
}

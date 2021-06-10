//
//  NestedViewController.swift
//  happySwift
//
//  Created by dfsx6 on 2021/6/10.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit
import JXSegmentedView

//MARK:-
class NestedViewController: BaseViewController {

    fileprivate lazy var layout = lazyLayout()
    fileprivate lazy var collectionView = lazyCollectionView()
    fileprivate lazy var segmentedView = lazySegmentedView()
    fileprivate lazy var segmentedTitleDataSource = lazySegmentedTitleDataSource()
    fileprivate lazy var segmentedListContainerView = lazySegmentedListContainerView()
    fileprivate var sectionHeadersPinHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationBar.backBtn.isHidden = true
        
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect.init(x: 0, y: safeAreaNavigationBar, width: view.frame.width, height: view.frame.height - safeAreaNavigationBar - safeAreaTabbar)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

//MARK:-
extension NestedViewController {
    ///
    fileprivate func lazyLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
    ///
    fileprivate func lazyCollectionView() -> UICollectionView {
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.exRegister(cell: NestedCollectionViewCell.self)
        collectionView.exRegister(supplementaryView: NestedCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        return collectionView
    }
    
    ///
    fileprivate func lazySegmentedView() -> JXSegmentedView {
        let segmentedView = JXSegmentedView.init()
        segmentedView.backgroundColor = .green
        segmentedView.dataSource = segmentedTitleDataSource
        segmentedView.listContainer = segmentedListContainerView
        return segmentedView
    }
    
    ///
    fileprivate func lazySegmentedTitleDataSource() -> JXSegmentedTitleDataSource {
        let dataSource = JXSegmentedTitleDataSource.init()
        dataSource.titles = ["x", "y", "z"]
        return dataSource
    }
    
    ///
    fileprivate func lazySegmentedListContainerView() -> JXSegmentedListContainerView {
        let segmentedListContainerView = JXSegmentedListContainerView.init(dataSource: self)
        return segmentedListContainerView
    }
    
}

//MARK:-
class NestedCollectionViewCell: UICollectionViewCell, DSReusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:-
class NestedCollectionReusableView: UICollectionReusableView, DSReusable {
    
    let label = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = self.bounds
    }
}

//MARK:-
extension NestedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 1
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.exDequeueReusableCell(for: indexPath, cellType: NestedCollectionViewCell.self) else {
            return UICollectionViewCell.init()
        }
        switch indexPath.section {
        case 2:
            cell.contentView.backgroundColor = .orange
            if segmentedListContainerView.superview != cell.contentView {
                cell.contentView.addSubview(segmentedListContainerView)
            }
            if segmentedListContainerView.frame != cell.contentView.bounds {
                segmentedListContainerView.frame = cell.contentView.bounds
            }
        case 1:
            cell.contentView.backgroundColor = .purple
        default:
            cell.contentView.backgroundColor = .green
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 2:
            return CGSize.init(width: view.frame.width, height: view.frame.height)
        default:
            return CGSize.init(width: view.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 2:
            return CGSize.init(width: view.frame.width, height: 50)
        default:
            return CGSize.init(width: view.frame.width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let reuseView = collectionView.exDequeueReusableSupplementaryView(ofKind: kind, for: indexPath, viewType: NestedCollectionReusableView.self) else {
            return UICollectionReusableView.init()
        }
        reuseView.label.text = "\(indexPath.section)"
        switch indexPath.section {
        case 2:
            sectionHeadersPinHeight = reuseView.frame.origin.y + reuseView.frame.size.height
            if segmentedView.superview != reuseView {
                reuseView.addSubview(segmentedView)
            }
            if segmentedView.frame != reuseView.bounds {
                segmentedView.frame = reuseView.bounds
            }
        default:
            break
        }
        return reuseView
    }
}

//MARK:-
extension NestedViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return 3
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = NestedListViewController.init(style: .grouped)
        (vc.tableView as UIScrollView).delegate = self
        return vc
    }
}

//MARK:-
extension NestedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(">>>>", scrollView.contentOffset, collectionView.contentOffset)
        if scrollView == collectionView {
            return
        }
        
        let point = scrollView.panGestureRecognizer.velocity(in: scrollView)
        
        if point.y < -5 {
            print("向上拖拽")
            if collectionView.contentOffset.y > sectionHeadersPinHeight {
                collectionView.contentOffset = CGPoint.init(x: 0, y: sectionHeadersPinHeight)
            } else {
                collectionView.contentOffset = scrollView.contentOffset
            }
        } else if point.y > 5 {
            print("向下拖拽")
            
            if collectionView.contentOffset.y < 0 {
                collectionView.contentOffset = CGPoint.zero
            } else {
                if scrollView.contentOffset.y < 0 {
                    collectionView.contentOffset = CGPoint.zero
                }
            }
            
        } else if point.y == 0 {
            print("停止拖拽")
        } else {
            print("//////")
        }
        
        
        
    }
}

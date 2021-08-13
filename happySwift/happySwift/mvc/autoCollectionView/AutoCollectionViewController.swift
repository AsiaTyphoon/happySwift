//
//  AutoCollectionViewController.swift
//  happySwift
//
//  Created by dfsx6 on 2021/7/16.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit
import MJRefresh

class AutoCollectionViewController: UIViewController {

    
    fileprivate lazy var layout: AutoCollectionViewFlowLayout = {
        let layout = AutoCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        //layout.sectionInset = .zero
        layout.sectionInset = UIEdgeInsets.init(top: 50, left: 0, bottom: 50, right: 0)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        layout.estimatedItemSize = CGSize.init(width: 100, height: 50)
        layout.headerReferenceSize = CGSize.init(width: 300, height: 50)
        layout.footerReferenceSize = CGSize.init(width: 300, height: 50)

        return layout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.exRegister(cell: AutoListOneCollectionViewCell.self)
        collectionView.exRegister(supplementaryView: AutoListOneCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.exRegister(supplementaryView: AutoListOneCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionFooter)
        collectionView.backgroundColor = .green
        collectionView.mj_header = self.refreshHeader

        return collectionView
    }()
    
    fileprivate var dataArr: [String] = []
    fileprivate var dataArr1: [String] = []
    
    /// 下拉刷新
    public private(set) lazy var refreshHeader: MJRefreshNormalHeader = {
        let refreshHeader = MJRefreshNormalHeader.init()
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(refreshAction))
        refreshHeader.lastUpdatedTimeLabel?.isHidden = true
        refreshHeader.stateLabel?.isHidden = true
        return refreshHeader
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        dataArr.append("当然你必须已经在cell中加了相应的约束，并且需要在layout中设置estimatedItemSize，设置的estimatedItemSize的width和约束的宽度最好一致。")
        dataArr.append("当然你必须已经在cell中加了相应。")
        dataArr.append("当然你必须已经在cell中加了相应。")
        dataArr.append("sssssssss。")
        dataArr.append("当然你必须已经在cell中加了相应的约束，并")
        dataArr.append("当然你必须已经在cell中加了相应。")

        dataArr.append("sssssssss。")


        
        dataArr1.append("当然你必须。")
        dataArr1.append("这种方法对于同一种cell没什么问题了，但若是多种cell，")
        dataArr1.append("当然你必须。00")


        
        view.addSubview(collectionView)
        
        view.backgroundColor = .red
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect.init(x: 0, y: safeAreaNavigationBar, width: view.bounds.width, height: view.bounds.height - safeAreaNavigationBar - safeAreaTabbar)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    ///
    @objc fileprivate func refreshAction() {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                self.collectionView.mj_header?.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }

}

//MARK:-
extension AutoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return dataArr.count
        } else if section == 1 {
            return dataArr1.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.exDequeueReusableCell(for: indexPath, cellType: AutoListOneCollectionViewCell.self) else {
            return UICollectionViewCell.init()
        }
        
        
        if indexPath.section == 0 {
            if indexPath.row < dataArr.count {
                let text = dataArr[indexPath.row]
                cell.titleLabel.text = "\(indexPath.section)-\(indexPath.row)\n\(text)"
                cell.subtitleLabel.text = text
                cell.bgWidth.constant = (self.view.frame.width - 3*layout.minimumInteritemSpacing - 1)/4

            }

        } else {
            if indexPath.row < dataArr1.count {
                let text = dataArr1[indexPath.row]
                cell.titleLabel.text = "\(indexPath.section)-\(indexPath.row)\n\(text)"
                cell.subtitleLabel.text = text

                if indexPath.row == 1 {
                    cell.subtitleLabel.text = nil
                }
                
                cell.bgWidth.constant = self.view.frame.width

            }
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.01
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.01
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if Int(indexPath.row) % 2 == 0 {
            return CGSize.init(width: (view.frame.width - 10)/2, height: 500)
        } else {
            return CGSize.init(width: (view.frame.width - 10)/2, height: 100)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let reuseView = collectionView.exDequeueReusableSupplementaryView(ofKind: kind, for: indexPath, viewType: AutoListOneCollectionReusableView.self) else {
            return UICollectionReusableView.init()
        }
        reuseView.titleLabel.text = "\(kind)-\(indexPath.section)-\(indexPath.row)"
        return reuseView
    }
}

//MARK:-
extension AutoCollectionViewController: AutoCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountAt section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }
    
    
}

//MARK:-
protocol AutoCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountAt section: Int) -> Int
}

//MARK:-
class AutoCollectionViewFlowLayout: UICollectionViewFlowLayout {

    fileprivate var maxColumnHeight: CGFloat = 0.0
    fileprivate var columnHeights: [Int : [CGFloat]] = [:]
    fileprivate var attrsArray: [UICollectionViewLayoutAttributes] = []
    fileprivate var showwater = false
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            return .zero
        }
        return CGSize.init(width: collectionView.frame.width, height: self.maxColumnHeight)
    }
    
    fileprivate var delegate: AutoCollectionViewDelegateFlowLayout? {
        return self.collectionView?.delegate as? AutoCollectionViewDelegateFlowLayout
    }
    
    fileprivate var dataSource: UICollectionViewDataSource? {
        return self.collectionView?.dataSource
    }
    
    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else {
            return
        }
        
        let numberOfSections = collectionView.numberOfSections
        if numberOfSections == 0 {
            return
        }
        maxColumnHeight = 0.0
        columnHeights.removeAll()
        
        for section in 0..<numberOfSections {
            let columnCount = delegate?.collectionView(collectionView, layout: self, columnCountAt: section) ?? 0
            var heights: [CGFloat] = []
            for _ in 0..<columnCount {
                heights.append(0)
            }
            columnHeights[section] = heights
        }
        
        print("prepare", columnHeights)
        
        attrsArray.removeAll()
        for section in 0..<numberOfSections {
            if let headerAtt = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(item: 0, section: section)) {
                attrsArray.append(headerAtt)
            }
            
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            for item in 0..<numberOfItems {
                let indexPath = IndexPath.init(item: item, section: section)
                if let itemAtt = self.layoutAttributesForItem(at: indexPath) {
                    attrsArray.append(itemAtt)
                }
            }
            
            if let footerAtt = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: IndexPath.init(item: 0, section: section)) {
                attrsArray.append(footerAtt)
            }

        }
       
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
        
        guard var layoutAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        //layoutAttributes = self.layoutWaterfallAttributes(layoutAttributes)

        return layoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let att = super.layoutAttributesForItem(at: indexPath) else {
            return nil
        }
        let frame = itemFrameOfVerticalWaterFlow(att, at: indexPath)
        att.frame = frame
        return att
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let att = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else {
            return nil
        }
        
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            let frame = headerViewFrameOfVerticalWaterFlow(indexPath)
            att.frame = frame
        case UICollectionView.elementKindSectionFooter:
            let frame = footerViewFrameOfVerticalWaterFlow(indexPath)
            att.frame = frame
        default:
            break
        }
        
        
        return att
    }
    
    ///
    fileprivate func itemFrameOfVerticalWaterFlow(_ attributes: UICollectionViewLayoutAttributes, at indexPath: IndexPath) -> CGRect {
        
        
        guard let collectionView = collectionView else {
            return .zero
        }
        
        let columnCount = delegate?.collectionView(collectionView, layout: self, columnCountAt: indexPath.section) ?? 0
        let numberOfItems = collectionView.numberOfItems(inSection: indexPath.section)

        let collectionW = collectionView.frame.size.width
        
//        let w = (collectionW - sectionInset.left - sectionInset.right - CGFloat(columnCount - 1) * minimumInteritemSpacing) / CGFloat(columnCount)
        let w = attributes.frame.size.width
        let h = attributes.frame.size.height

        var heights = columnHeights[indexPath.section]!
        
        if showwater {
            var destColumn: Int = 0
            var minColumnHeight = heights[0]
            for i in 0..<columnCount {
                let columnHeight = heights[i]
                if minColumnHeight > columnHeight {
                    minColumnHeight = columnHeight
                    destColumn = i
                }
            }
            
            let x = sectionInset.left + CGFloat(destColumn) * (w + minimumInteritemSpacing)
            var y = minColumnHeight
            
            
            let lineIndex = Int(ceil(CGFloat(Int(destColumn)%columnCount)))

            if indexPath.row < columnCount {
                y += sectionInset.top
            } else {
                y += minimumLineSpacing
            }
//            switch indexPath.row < col {
//            case 0:
//                y += sectionInset.top
//            default:
//                y += minimumLineSpacing
//            }
            
//            if y != sectionInset.top {
//                y += minimumLineSpacing
//            }
            
            let frame = CGRect.init(x: x, y: y, width: w, height: h)
            heights[destColumn] = frame.maxY
            
            let columnHeight = heights[destColumn]
            if maxColumnHeight < columnHeight {
                maxColumnHeight = columnHeight
            }
            
            // 最后一个加上bottom
            if indexPath.row == numberOfItems - 1 {
                maxColumnHeight += sectionInset.bottom
            }
            
            columnHeights[indexPath.section] = heights
            
            return frame


        } else {
            
            let x = attributes.frame.origin.x
            var y = attributes.frame.origin.y

            var heights = columnHeights[indexPath.section]!
            
//            let x = attributes.frame.origin.x
//            var y = attributes.frame.origin.y
            print("xxxxxx", x)
            let lineIndex = Int(ceil(CGFloat(Int(indexPath.row)%columnCount)))
            
            var destColumn: Int = 0
            var minColumnHeight = heights[0]
            for i in 0..<columnCount {
                let columnHeight = heights[i]
                if minColumnHeight > columnHeight {
                    minColumnHeight = columnHeight
                    destColumn = i
                }
            }
            
            if indexPath.row < columnCount {
                y = minColumnHeight + sectionInset.top
            } else {
                y = minColumnHeight + minimumLineSpacing
            }
            

            let frame = CGRect.init(x: x, y: y, width: w, height: h)
            heights[destColumn] = frame.maxY
            
            
            let columnHeight = heights[destColumn]
            if maxColumnHeight < columnHeight {
                maxColumnHeight = columnHeight
            }
            
            if indexPath.row != 0 {
                if Int(indexPath.row) % Int(columnCount) == (columnCount - 1) {
                    heights = heights.map({ (_) -> CGFloat in
                        return maxColumnHeight
                    })
                    columnHeights[indexPath.section] = heights
                }
            }
            
            if indexPath.row == numberOfItems - 1 {
                maxColumnHeight += sectionInset.bottom
            }
            
//                for i in 0..<columnCount {
//                    heights[i] = maxColumnHeight
//                }
            print("ddddd", maxColumnHeight, heights, destColumn)
            
            columnHeights[indexPath.section] = heights

            return frame
            
//            if columnCount == 1 {
//                y = maxColumnHeight
//                switch indexPath.row {
//                case 0:
//                    y += sectionInset.top
//                default:
//                    y += minimumLineSpacing
//                }
//
//                let frame = CGRect.init(x: x, y: y, width: w, height: h)
//
//                if maxColumnHeight < frame.maxY {
//                    maxColumnHeight = frame.maxY
//                }
//
//                // 最后一个添加上bottom
//                if indexPath.row == numberOfItems - 1 {
//                    maxColumnHeight += sectionInset.bottom
//                }
//
//                for i in 0..<columnCount {
//                    heights[i] = maxColumnHeight
//                }
//
//                columnHeights[indexPath.section] = heights
//
//                return frame
//
//
//
//            } else {
//
//                var heights = columnHeights[indexPath.section]!
//
//                let x = attributes.frame.origin.x
//                var y = attributes.frame.origin.y
//                print("xxxxxx", x)
//                let lineIndex = Int(ceil(CGFloat(Int(indexPath.row)%columnCount)))
//
//                var destColumn: Int = 0
//                var minColumnHeight = heights[0]
//                for i in 0..<columnCount {
//                    let columnHeight = heights[i]
//                    if minColumnHeight > columnHeight {
//                        minColumnHeight = columnHeight
//                        destColumn = i
//                    }
//                }
//
//                if indexPath.row < columnCount {
//                    y = minColumnHeight + sectionInset.top
//                } else {
//                    y = minColumnHeight + minimumLineSpacing
//                }
//
//
//                let frame = CGRect.init(x: x, y: y, width: w, height: h)
//                heights[destColumn] = frame.maxY
//
//
//                let columnHeight = heights[destColumn]
//                if maxColumnHeight < columnHeight {
//                    maxColumnHeight = columnHeight
//                }
//
//                if indexPath.row != 0 {
//                    if Int(indexPath.row) % Int(columnCount) == (columnCount - 1) {
//                        heights = heights.map({ (_) -> CGFloat in
//                            return maxColumnHeight
//                        })
//                        columnHeights[indexPath.section] = heights
//                    }
//                }
//
//                if indexPath.row == numberOfItems - 1 {
//                    maxColumnHeight += sectionInset.bottom
//                }
//
////                for i in 0..<columnCount {
////                    heights[i] = maxColumnHeight
////                }
//                print("ddddd", maxColumnHeight, heights, destColumn)
//
//                columnHeights[indexPath.section] = heights
//
//                return frame
//
//            }
            
            
            

        }
        


    }
    
    ///
    fileprivate func headerViewFrameOfVerticalWaterFlow(_ indexPath: IndexPath) -> CGRect {
        
        guard let collectionView = collectionView else {
            return .zero
        }
        
        let columnCount = delegate?.collectionView(collectionView, layout: self, columnCountAt: indexPath.section) ?? 0
        
        let x: CGFloat = 0
        var y = maxColumnHeight
        let headerSize = delegate?.collectionView?(collectionView, layout: self, referenceSizeForHeaderInSection: indexPath.section) ?? headerReferenceSize
        let footerSize = delegate?.collectionView?(collectionView, layout: self, referenceSizeForFooterInSection: indexPath.section) ?? footerReferenceSize
//        if footerSize.height > 0 {
//            y = (maxColumnHeight == 0) ? sectionInset.top : maxColumnHeight + minimumLineSpacing
//        }
        maxColumnHeight = y + headerSize.height
        columnHeights.removeAll()
        
        var heights: [CGFloat] = []
        for _ in 0..<columnCount {
            heights.append(maxColumnHeight)
        }
        columnHeights[indexPath.section] = heights
        
        return CGRect.init(x: x, y: y, width: collectionView.frame.size.width, height: headerSize.height)
        
    }
    
    ///
    fileprivate func footerViewFrameOfVerticalWaterFlow(_ indexPath: IndexPath) -> CGRect {
        
        guard let collectionView = collectionView else {
            return .zero
        }
        
        let columnCount = delegate?.collectionView(collectionView, layout: self, columnCountAt: indexPath.section) ?? 0

        
        let footerSize = delegate?.collectionView?(collectionView, layout: self, referenceSizeForFooterInSection: indexPath.section) ?? footerReferenceSize

        let x: CGFloat = 0
//        let y = (footerSize.height == 0) ? maxColumnHeight : maxColumnHeight + minimumLineSpacing
        let y = maxColumnHeight

        maxColumnHeight = y + footerSize.height
        columnHeights.removeAll()
        
        var heights: [CGFloat] = []
        for _ in 0..<columnCount {
            heights.append(maxColumnHeight)
        }
        columnHeights[indexPath.section] = heights
        
        return CGRect.init(x: x, y: y, width: collectionView.frame.size.width, height: footerSize.height)
        
    }

    
    /// 按照指定数量均分数组
    fileprivate func divideAttributesToRows(_ attributes: [UICollectionViewLayoutAttributes], by count: Int) -> [[UICollectionViewLayoutAttributes]] {
        var atts: [[UICollectionViewLayoutAttributes]] = []
        var dropAtts: [UICollectionViewLayoutAttributes] = attributes

        while dropAtts.count != 0 {
            let arr = Array(dropAtts.prefix(count))
            if arr.count > 0 {
                atts.append(arr)
                dropAtts.removeFirst(arr.count)
            }
        }
        return atts
    }
}





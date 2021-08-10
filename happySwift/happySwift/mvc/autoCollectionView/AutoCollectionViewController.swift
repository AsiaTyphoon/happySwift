//
//  AutoCollectionViewController.swift
//  happySwift
//
//  Created by dfsx6 on 2021/7/16.
//  Copyright © 2021 slardar. All rights reserved.
//

import UIKit
import MJRefresh
import AVKit

class AutoCollectionViewController: UIViewController {

    var item: AVPlayerItem?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    fileprivate lazy var layout: AutoCollectionViewFlowLayout = {
        let layout = AutoCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .zero
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
        
        dataArr.append("当然你必须已经在cell中加了相应的约束，并且需要在layout中设置estimatedItemSize，设置的estimatedItemSize的width和约束的宽度最好一致。")
        dataArr.append("当然你必须已经在cell中加了相应。")

        dataArr.append("sssssssss。")
        dataArr.append("当然你必须已经在cell中加了相应的约束，并")
        dataArr.append("当然你必须已经在cell中加了相应。")

        dataArr.append("sssssssss。")


        
        dataArr1.append("当然你必须。")
        dataArr1.append("这种方法对于同一种cell没什么问题了，但若是多种cell，")
        dataArr1.append("当然你必须。")


        
        //view.addSubview(collectionView)
        
//        item = AVPlayerItem.init(url: URL.init(string: "http://192.168.8.107:8000/api/file5/media/2021-07-13/920581824/DDF9B270542B4CA2AEAD2B6AE609D28Da1.wav")!)
        item = AVPlayerItem.init(url: URL.init(string: "https://192.168.8.107:8001/api/file5/media/2021-07-13/920581824/DDF9B270542B4CA2AEAD2B6AE609D28Da1.wav")!)
//        item = AVPlayerItem.init(url: URL.init(string: "http://filetest.baview.cn:33385/paike/videos/nmip-media/2021-06-29/302148527-v0-mp4/95548DFCF4F4A3179DC09DDA796E97A6.mp4")!)

        //
        player = AVPlayer.init(playerItem: item!)
        playerLayer = AVPlayerLayer.init(player: player!)
//        view.layer.insertSublayer(layer, at: 0)
        view.layer.addSublayer(playerLayer!)
        playerLayer?.backgroundColor = UIColor.green.cgColor
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.frame = CGRect.init(x: 10, y: 100, width: 300, height: 200)
        player?.play()

        view.backgroundColor = .red
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect.init(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height)
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return dataArr.count
        } else {
            return dataArr1.count
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
                cell.bgWidth.constant = (self.view.frame.width - layout.minimumInteritemSpacing)/2

            }

        } else {
            if indexPath.row < dataArr1.count {
                let text = dataArr1[indexPath.row]
                cell.titleLabel.text = "\(indexPath.section)-\(indexPath.row)\n\(text)"
                cell.subtitleLabel.text = text

                if indexPath.row == 1 {
                    cell.subtitleLabel.text = nil
                }
                
                cell.bgWidth.constant = self.view.frame.width/3

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
class AutoCollectionViewFlowLayout: UICollectionViewFlowLayout {

    fileprivate var maxColumnHeight: CGFloat = 0.0
    fileprivate var columnHeights: [CGFloat] = []
    fileprivate var columnCount: Int = 2
    fileprivate var attrsArray: [UICollectionViewLayoutAttributes] = []
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            return .zero
        }
        return CGSize.init(width: collectionView.frame.width, height: self.maxColumnHeight)
    }
    
    override func prepare() {
        super.prepare()

        maxColumnHeight = 0.0
        columnHeights.removeAll()
        for _ in 0..<columnCount {
            columnHeights.append(sectionInset.top)
        }
        
        attrsArray.removeAll()
        let numberOfSections = collectionView?.numberOfSections ?? 0
        for section in 0..<numberOfSections {
            if let headerAtt = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(item: 0, section: section)) {
                attrsArray.append(headerAtt)
            }
            
            let numberOfItems = collectionView?.numberOfItems(inSection: section) ?? 0
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
        let frame = itemFrameOfVerticalWaterFlow(att)
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
    fileprivate func itemFrameOfVerticalWaterFlow(_ attributes: UICollectionViewLayoutAttributes) -> CGRect {
        
        guard let collectionView = collectionView else {
            return .zero
        }
        
        let collectionW = collectionView.frame.size.width
        
//        let w = (collectionW - sectionInset.left - sectionInset.right - CGFloat(columnCount - 1) * minimumInteritemSpacing) / CGFloat(columnCount)
        let w = attributes.frame.size.width
        let h = attributes.frame.size.height

        var destColumn: Int = 0
        var minColumnHeight = columnHeights[0]
        for i in 0..<columnCount {
            let columnHeight = columnHeights[i]
            if minColumnHeight > columnHeight {
                minColumnHeight = columnHeight
                destColumn = i
            }
        }
        
        let x = sectionInset.left + CGFloat(destColumn) * (w + minimumInteritemSpacing)
        var y = minColumnHeight
        if y != sectionInset.top {
            y += minimumLineSpacing
        }
        
        let frame = CGRect.init(x: x, y: y, width: w, height: h)
        columnHeights[destColumn] = frame.maxY
        
        let columnHeight = columnHeights[destColumn]
        if maxColumnHeight < columnHeight {
            maxColumnHeight = columnHeight
        }
        return frame

    }
    
    ///
    fileprivate func headerViewFrameOfVerticalWaterFlow(_ indexPath: IndexPath) -> CGRect {
        
        guard let collectionView = collectionView else {
            return .zero
        }
        
        guard let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
            return .zero
        }
        
        let x: CGFloat = 0
        var y = (maxColumnHeight == 0) ? sectionInset.top : maxColumnHeight
        let headerSize = delegate.collectionView?(collectionView, layout: self, referenceSizeForHeaderInSection: indexPath.section) ?? headerReferenceSize
        let footerSize = delegate.collectionView?(collectionView, layout: self, referenceSizeForFooterInSection: indexPath.section) ?? footerReferenceSize
        if footerSize.height > 0 {
            y = (maxColumnHeight == 0) ? sectionInset.top : maxColumnHeight + minimumLineSpacing
        }
        maxColumnHeight = y + headerSize.height
        columnHeights.removeAll()
        for _ in 0..<columnCount {
            columnHeights.append(maxColumnHeight)
        }
        return CGRect.init(x: x, y: y, width: collectionView.frame.size.width, height: headerSize.height)
        
    }
    
    ///
    fileprivate func footerViewFrameOfVerticalWaterFlow(_ indexPath: IndexPath) -> CGRect {
        
        guard let collectionView = collectionView else {
            return .zero
        }
        
        guard let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
            return .zero
        }
        
        let footerSize = delegate.collectionView?(collectionView, layout: self, referenceSizeForFooterInSection: indexPath.section) ?? footerReferenceSize

        let x: CGFloat = 0
        var y = (footerSize.height == 0) ? maxColumnHeight : maxColumnHeight + minimumLineSpacing
        
        maxColumnHeight = y + footerSize.height
        columnHeights.removeAll()
        for _ in 0..<columnCount {
            columnHeights.append(maxColumnHeight)
        }
        return CGRect.init(x: x, y: y, width: collectionView.frame.size.width, height: footerSize.height)
        
    }

    
    /*
     //返回头视图的布局frame
     - (CGRect)headerViewFrameOfVerticalWaterFlow:(NSIndexPath *)indexPath{
         
         CGSize size = CGSizeZero;
         
         if([self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForHeaderViewInSection:)]){
             size = [self.delegate waterFlowLayout:self sizeForHeaderViewInSection:indexPath.section];
         }
         
         if (self.flowLayoutStyle == WSLWaterFlowVerticalEqualWidth) {
             
             CGFloat x = 0;
             CGFloat y = self.maxColumnHeight == 0 ? self.edgeInsets.top : self.maxColumnHeight;
             if (![self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForFooterViewInSection:)] || [self.delegate waterFlowLayout:self sizeForFooterViewInSection:indexPath.section].height == 0) {
                 y = self.maxColumnHeight == 0 ? self.edgeInsets.top : self.maxColumnHeight + self.rowMargin;
             }
             
             self.maxColumnHeight = y + size.height ;
             
             [self.columnHeights removeAllObjects];
             for (NSInteger i = 0; i < self.columnCount; i++) {
                 [self.columnHeights addObject:@(self.maxColumnHeight)];
             }
             
             return CGRectMake(x , y, self.collectionView.frame.size.width, size.height);
             
         }else if (self.flowLayoutStyle == WSLWaterFlowVerticalEqualHeight){
             
             CGFloat x = 0;
             CGFloat y = self.maxColumnHeight == 0 ? self.edgeInsets.top : self.maxColumnHeight;
             if (![self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForFooterViewInSection:)] || [self.delegate waterFlowLayout:self sizeForFooterViewInSection:indexPath.section].height == 0) {
                 y = self.maxColumnHeight == 0 ? self.edgeInsets.top : self.maxColumnHeight + self.rowMargin;
             }
             
             self.maxColumnHeight = y + size.height ;
             
             [self.rowWidths replaceObjectAtIndex:0 withObject:@(self.collectionView.frame.size.width)];
             [self.columnHeights replaceObjectAtIndex:0 withObject:@(self.maxColumnHeight)];
             
             return CGRectMake(x , y, self.collectionView.frame.size.width, size.height);
             
             
         }else if (self.flowLayoutStyle == WSLWaterFlowHorizontalEqualHeight){
             
             
             
         }
         
         return CGRectMake(0, 0, 0, 0);
         
     }
     //返回脚视图的布局frame
     - (CGRect)footerViewFrameOfVerticalWaterFlow:(NSIndexPath *)indexPath{
         
         CGSize size = CGSizeZero;
         
         if([self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForFooterViewInSection:)]){
             size = [self.delegate waterFlowLayout:self sizeForFooterViewInSection:indexPath.section];
         }
         
         if (self.flowLayoutStyle == WSLWaterFlowVerticalEqualWidth ) {
             
             CGFloat x = 0;
             CGFloat y = size.height == 0 ? self.maxColumnHeight : self.maxColumnHeight + self.rowMargin;
             
             self.maxColumnHeight = y + size.height;
             
             [self.columnHeights removeAllObjects];
             for (NSInteger i = 0; i < self.columnCount; i++) {
                 [self.columnHeights addObject:@(self.maxColumnHeight)];
             }
             
             return  CGRectMake(x , y, self.collectionView.frame.size.width, size.height);
             
         }else if (self.flowLayoutStyle == WSLWaterFlowVerticalEqualHeight){
             
             CGFloat x = 0;
             CGFloat y = size.height == 0 ? self.maxColumnHeight : self.maxColumnHeight + self.rowMargin;
             
             self.maxColumnHeight = y + size.height;
             
             [self.rowWidths replaceObjectAtIndex:0 withObject:@(self.collectionView.frame.size.width)];
             [self.columnHeights replaceObjectAtIndex:0 withObject:@(self.maxColumnHeight)];
             
             return  CGRectMake(x , y, self.collectionView.frame.size.width, size.height);
             
         }else if (self.flowLayoutStyle == WSLWaterFlowHorizontalEqualHeight){
             
             
             
         }
         
         return CGRectMake(0, 0, 0, 0);
         
     }
     */
    
    /// cell瀑布流
    fileprivate func layoutWaterfallAttributes(_ layoutAttributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {

        guard let collectionView = collectionView else {
            return layoutAttributes
        }

        if layoutAttributes.first?.frame.size == CGSize.init(width: 50, height: 50) {
            return layoutAttributes
        }

        var sectionLayoutAttributes: [Int: [UICollectionViewLayoutAttributes]] = [:]
        // 根据section分组
        let sectionCount = collectionView.numberOfSections
        for section in 0..<sectionCount {
            let attributes = layoutAttributes.filter{ $0.indexPath.section == section }
            sectionLayoutAttributes[section] = attributes
        }
        // 每个section单独处理
        for (section, dic) in sectionLayoutAttributes.enumerated() {

            if dic.value.count == 0 {
                continue
            }

            guard let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
                continue
            }
            // 获取inserSection
            let inset = delegate.collectionView?(collectionView, layout: self, insetForSectionAt: section) ?? .zero
            // 获取列间距
            let interitemSpacing = delegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: section) ?? self.minimumInteritemSpacing
            // 获取列间距
            let lineSpacing = delegate.collectionView?(collectionView, layout: self, minimumLineSpacingForSectionAt: section) ?? self.minimumLineSpacing

            // 获取itemSize
            let size = dic.value.first?.frame.size ?? self.itemSize
            // 获取列数
            let itemCount = Int(collectionView.frame.width - inset.left - inset.right + interitemSpacing) / Int(size.width + interitemSpacing)
            if itemCount <= 1 {
                continue
            }

            // 按照单列数量均分,即行列表
            let items = self.divideAttributesToItems(dic.value, by: itemCount)
            items.forEach { (atts) in
                var originY: CGFloat = 0
                for (i, att) in atts.enumerated() {
                    if i == 0 {
                        originY = 0
                        att.frame.origin.y = originY
                        originY += (att.frame.size.height + lineSpacing)
                    } else {
                        att.frame.origin.y = originY
                        originY += (att.frame.size.height + lineSpacing)
                    }
                }
            }
        }

        return layoutAttributes
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

    /// 按照指定列数均分数组
    fileprivate func divideAttributesToItems(_ attributes: [UICollectionViewLayoutAttributes], by count: Int) -> [[UICollectionViewLayoutAttributes]] {
        var atts: [[UICollectionViewLayoutAttributes]] = []

        for index in 0..<count {
            var arr: [UICollectionViewLayoutAttributes] = []
            for att in attributes {
                let row = Int(ceil(CGFloat(Int(att.indexPath.row)%count)))
                if row == index {
                    arr.append(att)
                }
            }
            if arr.count > 0 {
                atts.append(arr)
            }
        }

        return atts
    }
    
}





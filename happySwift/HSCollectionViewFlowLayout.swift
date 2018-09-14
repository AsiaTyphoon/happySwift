//
//  DSCollectionViewFlowLayout.swift
//  乐山城事
//
//  Created by DFSX on 2018/9/4.
//  Copyright © 2018年 com.dfsx. All rights reserved.
//

import UIKit

enum DSAlignType: NSInteger {
    case left = 0
    case center = 1
    case right = 2
}

class DSCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var betweenOfCell: CGFloat {
        didSet{
            self.minimumInteritemSpacing = betweenOfCell
        }
    }
    
    //cell对齐方式
    var cellType: DSAlignType = DSAlignType.center
    
    //在居中对齐的时候需要知道这行所有cell的宽度总和
    var sumCellWidth: CGFloat = 0.0
    
    override init() {
        betweenOfCell = 11.0
        super.init()
        scrollDirection = UICollectionViewScrollDirection.horizontal
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    convenience init(_ cellType: DSAlignType){
        self.init()
        self.cellType = cellType
    }
    
    convenience init(_ cellType: DSAlignType, _ betweenOfCell: CGFloat){
        self.init()
        self.cellType = cellType
        self.betweenOfCell = betweenOfCell
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes_super : [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes]()
        let layoutAttributes:[UICollectionViewLayoutAttributes] = NSArray(array: layoutAttributes_super, copyItems:true)as! [UICollectionViewLayoutAttributes]
        var layoutAttributes_t : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for index in 0..<layoutAttributes.count {
            
            let currentAttr = layoutAttributes[index]
            let previousAttr = index == 0 ? nil : layoutAttributes[index-1]
            let nextAttr = index + 1 == layoutAttributes.count ?
                nil : layoutAttributes[index+1]
            
            layoutAttributes_t.append(currentAttr)
            sumCellWidth += currentAttr.frame.size.width
            
            let previousY :CGFloat = previousAttr == nil ? 0 : previousAttr!.frame.maxY
            let currentY :CGFloat = currentAttr.frame.maxY
            let nextY:CGFloat = nextAttr == nil ? 0 : nextAttr!.frame.maxY
            
            if currentY != previousY && currentY != nextY{
                if currentAttr.representedElementKind == UICollectionElementKindSectionHeader {
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                } else if currentAttr.representedElementKind == UICollectionElementKindSectionFooter {
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                } else{
                    self.setCellFrame(with: layoutAttributes_t)
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }
            } else if currentY != nextY{
                self.setCellFrame(with: layoutAttributes_t)
                layoutAttributes_t.removeAll()
                sumCellWidth = 0.0
            }
        }
        return layoutAttributes
    }
    
    /// 调整Cell的Frame
    ///
    /// - Parameter layoutAttributes: layoutAttribute 数组
    func setCellFrame(with layoutAttributes: [UICollectionViewLayoutAttributes]) {
        var nowWidth : CGFloat = 0.0
        switch cellType {
        case .left:
            nowWidth = self.sectionInset.left
            for attributes in layoutAttributes {
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.betweenOfCell
            }
            break;
        case .center:
            nowWidth = (self.collectionView!.frame.size.width - sumCellWidth - (CGFloat(layoutAttributes.count - 1) * betweenOfCell)) / 2
            for attributes in layoutAttributes {
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.betweenOfCell
            }
            break;
        case .right:
            nowWidth = self.collectionView!.frame.size.width - self.sectionInset.right
            for var index in 0 ..< layoutAttributes.count {
                index = layoutAttributes.count - 1 - index
                let attributes = layoutAttributes[index]
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth - nowFrame.size.width
                attributes.frame = nowFrame
                nowWidth = nowWidth - nowFrame.size.width - betweenOfCell
            }
            break;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        betweenOfCell = 11.0
        super.init(coder: aDecoder)
        scrollDirection = UICollectionViewScrollDirection.horizontal
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
}

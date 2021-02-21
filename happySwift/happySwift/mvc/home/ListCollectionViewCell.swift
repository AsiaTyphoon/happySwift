//
//  ListCollectionViewCell.swift
//  happySwift
//
//  Created by dfsx6 on 2020/9/30.
//  Copyright © 2020 slardar. All rights reserved.
//

import UIKit

//MARK:-
class ListItemViewModel: NSObject, DSVMRowProtocol {
    
    func sizeForItem(for collectionView: UICollectionView, at indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: kSCREENW, height: 100)
    }
    
    func registCell(for collectionView: UICollectionView) {
        collectionView.exRegister(cell: ListCollectionViewCell.self)
    }
    
    func dequeueReusableCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.exDequeueReusableCell(for: indexPath, cellType: ListCollectionViewCell.self) else {
            return UICollectionViewCell.init()
        }
        return cell
    }
    
    
}

class sss: DSVMCollection {
    override func refreshData(success: @escaping ([DSVMSectionProtocol]) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            print("1111")
            success([SectionModel.init(), SectionModel.init(), SectionModel.init()])
        }
    }
    
}

//MARK:-
class ListItem: NSObject {
    
}

//MARK:-
class ListCollectionViewCell: UICollectionViewCell, DSNibReusable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .green
    }

}

//
//  DSVMCollectionViewRowProtocol.swift
//  core
//
//  Created by dfsx6 on 2020/10/16.
//  Copyright © 2020 jianglin. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
public protocol DSVMCollectionViewRowProtocol: NSObjectProtocol {
            
    var cell: UICollectionViewCell! { get set }
    var indexPath: IndexPath! { get set }
    var collectionView: UICollectionView? { get set }

    func registCell(for collectionView: UICollectionView)
    func dequeueReusableCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    func sizeForRow(for collectionView: UICollectionView, at indexPath: IndexPath) -> CGSize
    func didSelectRow(for collectionView: UICollectionView, at indexPath: IndexPath)
}

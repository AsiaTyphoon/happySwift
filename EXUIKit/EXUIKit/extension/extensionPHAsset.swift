//
//  extensionPHAsset.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import Photos

//MARK:-
public extension PHAsset {
    
    /// 获取图片
    /// - returns :
    func exRequestImage(handler: @escaping ( _ imageData: Data?) -> Void ) {
        
        if self.mediaType != .image {
            handler(nil)
            return
        }
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        PHImageManager.default().requestImageData(for: self, options: options) { (rdata, rstr, orientation, hashable) in
            handler(rdata)
        }
    }
}

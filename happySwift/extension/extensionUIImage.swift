//
//  extensionUIImage.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/17.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func epScaleByWidth(of: CGFloat) -> UIImage {
        let w: CGFloat = of * self.scale
        let h: CGFloat = self.size.height / self.size.width * of * self.scale
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: w, height: h))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func createImageInRect(of: CGRect) -> UIImage {
        let imgRef = self.cgImage
        guard let newImgRef = imgRef?.cropping(to: of) else {
            return self
        }
        return UIImage(cgImage: newImgRef)
    }
    
}

//
//  HSDefine.swift
//  happySwift
//
//  Created by dfsx1 on 2018/9/14.
//  Copyright © 2018年 slardar. All rights reserved.
//

import Foundation
import UIKit

var kSCREENW = UIScreen.main.bounds.width
var kSCREENH = UIScreen.main.bounds.height

func MIN(_ A: CGFloat, _ B: CGFloat) -> CGFloat {
    if A > B { return B } else { return A }
}

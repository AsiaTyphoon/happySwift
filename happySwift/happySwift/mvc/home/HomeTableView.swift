//
//  HomeTableView.swift
//  happySwift
//
//  Created by dfsx6 on 2021/5/24.
//  Copyright © 2021 slardar. All rights reserved.
//

import Foundation

//MARK:-
class HomeTableView: DSVMTableView {
    
    
    
    override func refreshData(success: @escaping ([DSVMTableViewRowProtocol]) -> Void, failure: @escaping (NSError) -> Void) {
        
        var dataArr: [DSVMTableViewRowProtocol] = []
        for _ in 0...100 {
            dataArr.append(TMSTableViewRow.init())
        }
        success(dataArr)
    }
}

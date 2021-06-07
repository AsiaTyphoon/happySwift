//
//  TMSTableView.swift
//  happySwift
//
//  Created by dfsx6 on 2021/5/24.
//  Copyright © 2021 slardar. All rights reserved.
//

import Foundation

//MARK:-
class TMSTableView: DSVMTableView {
    
    override func refreshData(success: @escaping ([DSVMTableViewRowProtocol]) -> Void, failure: @escaping (NSError) -> Void) {
        
        var dataArr: [DSVMTableViewRowProtocol] = []
        dataArr.append(TMSTableViewRow.init())
        dataArr.append(TMSTableViewRow.init())
        dataArr.append(TMSTableViewMenu.init())
        success(dataArr)
    }
}

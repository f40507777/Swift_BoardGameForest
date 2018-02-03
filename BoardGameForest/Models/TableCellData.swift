//
//  TableCellData.swift
//  BoardGameForest
//
//  Created by Finn on 2018/2/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class TableCellData: NSObject {
    var title: String = ""
    var clickAciotn: (() -> ())? = nil
    
    init(title: String, clickAciotn: @escaping (() -> ())) {
        super.init()
        
        self.title = title;
        self.clickAciotn = clickAciotn
    }
}

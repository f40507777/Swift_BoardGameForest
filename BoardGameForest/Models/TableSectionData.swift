//
//  TableSectionData.swift
//  BoardGameForest
//
//  Created by Finn on 2018/2/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class TableSectionData: NSObject {
    var title: String = ""
    var cellArray: [TableCellData] = []
    
    init(title: String, cellArray: [TableCellData]) {
        super.init()
        
        self.title = title;
        self.cellArray = cellArray
    }
}

//
//  BGBarChartDataSet.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/12.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class BGBarChartDataSet: NSObject {
    
    var title: String = ""
    
    var chartEntryArray: [BGBarChartEntry] = []
    
    init(entryArray: [BGBarChartEntry], title: String) {
        super.init()
        
        self.chartEntryArray = entryArray
        self.title = title
    }
}

//
//  BGBarChartEntry.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/7.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class BGBarChartEntry: NSObject {
    
    var yValue: Double = 0
    
    var xNameLabel: String = ""
    
    var setType: Int = 0
    
    init(yValue: Double, xNameLabel: String, setType: Int) {
        super.init()
        
        self.yValue = yValue
        self.xNameLabel = xNameLabel
        self.setType = setType
    }
}

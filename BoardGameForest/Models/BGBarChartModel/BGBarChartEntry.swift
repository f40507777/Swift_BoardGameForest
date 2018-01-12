//
//  BGBarChartEntry.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/7.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class BGBarChartEntry: NSObject {
    
    var value: Double = 0
    
    var name: String = ""
    
    init(value: Double, name: String) {
        super.init()
        
        self.value = value
        self.name = name
    }
}

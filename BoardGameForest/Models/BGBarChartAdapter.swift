//
//  BGBarChartAdapter.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/7.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit
import Charts

class BGBarChartAdapter: NSObject {
    
    var allChartEntryArray: Array<BGBarChartEntry> = []
        
    var chartSetArray: Array<BarChartDataSet> = []


    init(chartEntryArray:Array<BGBarChartEntry>, titleArray:Array<String>) {
        super.init()
        
        self.allChartEntryArray = chartEntryArray
        self.chartSetArray = self.initChartSetArray(titleArray: titleArray)
    }
    
    func initChartSetArray(titleArray: [String]) -> Array<BarChartDataSet> {
        var barChartDataSetArray = titleArray.map({BarChartDataSet(values: nil, label: $0)
        })
        for (index, element) in allChartEntryArray.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: element.yValue)
            if barChartDataSetArray[element.setType].addEntry(entry) {
            }
        }
        
        return barChartDataSetArray
    }
    
    
}

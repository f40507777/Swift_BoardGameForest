//
//  BGYearRevenueBarChartFactory.swift
//  BoardGameForest
//
//  Created by Finn on 2018/2/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class BGYearRevenueBarChartFactory: NSObject {

    var chartDataSet: [BGBarChartDataSet] = []
    
    init(yearRevenueArray: [Int], offsetYear: Int) {
        super.init()
        
        self.chartDataSet = getChartDataSet(revenueArray: yearRevenueArray,
                                            offsetYear: offsetYear)
    }
    
    func getChartDataSet(revenueArray: [Int], offsetYear: Int) -> [BGBarChartDataSet] {
        var dataSetArray: [BGBarChartDataSet] = []
        for (index, incoming) in revenueArray.enumerated() {
            let entry = BGBarChartEntry.init(value: Double(incoming), name: String(offsetYear + index)+"年")
            dataSetArray.append(BGBarChartDataSet(entryArray: [entry], title: ""))
        }
        
        return dataSetArray
    }
}

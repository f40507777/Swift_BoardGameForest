//
//  BGMonthRevenueBarChartFactory.swift
//  BoardGameForest
//
//  Created by Finn on 2018/2/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class BGMonthRevenueBarChartFactory: NSObject {

    var chartDataSet: [BGBarChartDataSet] = []

    init(monthsRevenueArray: [Int]) {
        super.init()
        
        self.chartDataSet = getChartDataSet(revenueArray: monthsRevenueArray)
    }
    
    func getChartDataSet(revenueArray: [Int]) -> [BGBarChartDataSet] {
        var entryArray: [BGBarChartEntry] = []
        for (index, incoming) in revenueArray.enumerated() {
            entryArray.append(BGBarChartEntry.init(value: Double(incoming), name: String(index + 1)+"月"))
        }
        
        return [BGBarChartDataSet(entryArray: entryArray, title: "月份")]
    }
}

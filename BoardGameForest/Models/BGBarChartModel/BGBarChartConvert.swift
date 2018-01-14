//
//  BGBarChartCovert.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/12.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit
import Charts

enum ValueUnit {
    case DollarUnit
    case NoneUnit
}

class BGBarChartConvert: NSObject {
    
    var barChartData = BarChartData()
    
    var titleList:[String] = []
    
    var valueUnit:ValueUnit = ValueUnit.NoneUnit
    
    var colors: [NSUIColor] = ChartColorTemplates.material() + ChartColorTemplates.colorful() + ChartColorTemplates.joyful() + ChartColorTemplates.pastel() + ChartColorTemplates.liberty()
    
    init(bgSetArray: [BGBarChartDataSet],valueUnit: ValueUnit) {
        super.init()

        setupBarCharData()
        self.valueUnit = valueUnit
        coverData(setArray: bgSetArray)
    }
    
    func setupBarCharData() {
        barChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        barChartData.barWidth = 0.9
    }
    
    func coverData(setArray: [BGBarChartDataSet]) {
        
        var indexCount = 0
        for (setIndex, bgSet) in setArray.enumerated() {
            var chartEntryArray: [BarChartDataEntry] = []
            for bgEntry in bgSet.chartEntryArray {
                chartEntryArray.append(BarChartDataEntry(x: Double(indexCount),
                                                         y: bgEntry.value))
                titleList.append(bgEntry.name)
                indexCount += 1
            }
            let barchartDataSet = BarChartDataSet(values: chartEntryArray, label: bgSet.title)
            barchartDataSet.setColor(getColor(index: setIndex))
            barChartData.addDataSet(barchartDataSet)
        }
    }
    
    func getColor(index: Int) -> NSUIColor {
        return colors[index % colors.count]
    }
    
}

//
//  BGBarChartFactory.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/29.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class BGItemSaleBarChartFactory: NSObject {
    
    var chartDataSet: [BGBarChartDataSet] = []
    
    lazy var meals = MenuParser().mealArray

    init(itemIDArray: [String], isHiddenEmptyItem: Bool) {
        super.init()
        
        self.chartDataSet = getChartDataSet(itemIDArray: itemIDArray, isHiddenEmpty: isHiddenEmptyItem)
    }
    
    func getChartDataSet(itemIDArray: [String], isHiddenEmpty: Bool) -> [BGBarChartDataSet] {
        var dataSetArray: [BGBarChartDataSet] = []
        for mealType in meals {
            var entryArray: [BGBarChartEntry] = []
            for meal in mealType {
                let itemCount = itemIDArray.filter{$0 == meal.itemID}.count
                if (itemCount > 0 || !isHiddenEmpty) {
                    entryArray.append(BGBarChartEntry.init(value: Double(itemCount), name: meal.aka!))
                }
            }
            if (entryArray.count > 0) {
                dataSetArray.append(BGBarChartDataSet(entryArray: entryArray, title: (MealType(rawValue: (mealType.first?.type)!)?.getName())!))
            }
        }

        return dataSetArray
    }
}

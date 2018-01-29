//
//  BGBarChartFactory.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/29.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class BGBarChartFactory: NSObject {
    
    var chartDataSet: [BGBarChartDataSet] = []
    
    var isHiddenEmptyItem: Bool = true
    
    lazy var meals = MenuParser().mealArray

    init(itemIDArray: [String], isHiddenEmptyItem: Bool) {
        super.init()
        
        self.isHiddenEmptyItem = isHiddenEmptyItem
        self.chartDataSet = getChartDataSet(itemIDArray: itemIDArray)
    }
    
    func getChartDataSet(itemIDArray: [String]) -> [BGBarChartDataSet] {
        var dataSetArray: [BGBarChartDataSet] = []
        for mealType in meals {
            var entryArray: [BGBarChartEntry] = []
            for meal in mealType {
                let itemCount = itemIDArray.filter{$0 == meal.itemID}.count
                if (itemCount > 0 || !isHiddenEmptyItem) {
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

//
//  AllItemSaleChartConvertData.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/14.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class AllItemSaleChartConvertData: NSObject, DatabaseAPIDelegate {
    
    lazy var databaseAPI = DatabaseAPI()
    
    func asyncQuary(callback: @escaping (BGBarChartConvert?, Error?) -> Void) {
        databaseAPI.delegate = self
        databaseAPI.getOrderListByTimeRange(startTimeStamp: TimeFormate().getNearlyMonthsTimeStamp(nearlyMonth: 1),
                                            endTimeStamp:  TimeFormate().getTommorrowTimeStamp()) { (orderList, error) in
                                                callback(BGBarChartConvert(bgSetArray: self.processOrderList(originalOrderList: orderList!), valueUnit: .DollarUnit), nil)

        }
    }
    
    private func processOrderList(originalOrderList: Array<Order>) -> [BGBarChartDataSet]{
        var tempAllItemID: [String] = []
        for orderList in originalOrderList {
            for mealStatus in orderList.mealStatusList {
                tempAllItemID.append(mealStatus.itemID!)
            }
        }
        
        return BGBarChartFactory(itemIDArray: tempAllItemID, isHiddenEmptyItem: true).chartDataSet
    }
    
    func dataChangeEvent(databaseOrders: Array<Order>) {}
    func todayDataChangeEvent(databaseOrders: Array<Order>) {}
}

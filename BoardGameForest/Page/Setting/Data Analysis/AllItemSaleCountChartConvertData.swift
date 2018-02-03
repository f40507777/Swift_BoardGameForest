//
//  AllItemSaleChartConvertData.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/14.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class AllItemSaleCountChartConvertData: NSObject, DatabaseAPIDelegate {
    
    lazy var databaseAPI = DatabaseAPI()
    
    var nearlyDay:Int = 1
    
    
    init(nearlyDay: Int) {
        super.init()
        
        self.nearlyDay = nearlyDay
    }
    
    func asyncQuary(callback: @escaping (BGBarChartConvert?, Error?) -> Void) {
        let startTime = nearlyDay == 1 ? TimeFormate().getTodayWorkTimeStamp() : TimeFormate().getNearlyDaysTimeStamp(day: nearlyDay)
        databaseAPI.delegate = self
        databaseAPI.getOrderListByTimeRange(startTimeStamp: startTime,
                                            endTimeStamp: TimeFormate().getCurrentTimeStamp()) { (orderList, error) in
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
        
        return BGItemSaleBarChartFactory(itemIDArray: tempAllItemID, isHiddenEmptyItem: false).chartDataSet
    }
    
    func dataChangeEvent(databaseOrders: Array<Order>) {}
    func todayDataChangeEvent(databaseOrders: Array<Order>) {}
}

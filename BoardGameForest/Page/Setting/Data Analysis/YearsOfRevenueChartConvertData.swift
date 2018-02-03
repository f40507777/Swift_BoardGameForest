//
//  YearsOfRevenueChartConvertData.swift
//  BoardGameForest
//
//  Created by Finn on 2018/2/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class YearsOfRevenueChartConvertData: NSObject, DatabaseAPIDelegate {
    let nearlyYear = 5

    lazy var databaseAPI = DatabaseAPI()
    
    func asyncQuary(callback: @escaping (BGBarChartConvert?, Error?) -> Void) {
        databaseAPI.delegate = self
        let startTime = TimeFormate().getNearlyYearsTimeStamp(year: nearlyYear)
        databaseAPI.getOrderListByTimeRange(startTimeStamp: startTime,
                                            endTimeStamp: TimeFormate().getCurrentTimeStamp()) { (orderList, error) in
                                            
                                                callback(BGBarChartConvert(bgSetArray: self.processOrderList(originalOrderList: orderList!), valueUnit: .DollarUnit), nil)
                                                
        }
    }
    
    private func processOrderList(originalOrderList: Array<Order>) -> [BGBarChartDataSet]{
        var revenueOfYear = Array(repeating: 0, count: nearlyYear)
        for orderList in originalOrderList {
            let year = getYearByTimeStamp(timeStamp: orderList.createTime)
            revenueOfYear[year - getOffsetYear()] += orderList.totalAmount
        }
        
        return BGYearRevenueBarChartFactory(yearRevenueArray: revenueOfYear, offsetYear: getOffsetYear()).chartDataSet
    }
    
    func getYearByTimeStamp(timeStamp: Double) -> Int {
        let date = Date(timeIntervalSince1970: timeStamp)
        
        return Calendar.current.component(.year, from: date)
    }
    
    func getOffsetYear() -> Int {
        let currentYear = getYearByTimeStamp(timeStamp: TimeFormate().getCurrentTimeStamp())
        
        return currentYear - nearlyYear + 1
    }
    
    func dataChangeEvent(databaseOrders: Array<Order>) {}
    func todayDataChangeEvent(databaseOrders: Array<Order>) {}
}

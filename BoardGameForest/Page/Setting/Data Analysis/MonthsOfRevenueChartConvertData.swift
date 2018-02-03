//
//  yearsOfRevenueChartConvertData.swift
//  BoardGameForest
//
//  Created by Finn on 2018/2/3.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class MonthsOfRevenueChartConvertData: NSObject, DatabaseAPIDelegate {
    lazy var databaseAPI = DatabaseAPI()
    
    func asyncQuary(callback: @escaping (BGBarChartConvert?, Error?) -> Void) {
        databaseAPI.delegate = self
        databaseAPI.getYearOrderList { (orderlist, error) in
            callback(BGBarChartConvert(bgSetArray: self.processOrderList(originalOrderList: orderlist!), valueUnit: .DollarUnit), nil)
        }
    }
    
    private func processOrderList(originalOrderList: Array<Order>) -> [BGBarChartDataSet]{
        var revenueOfMonth = Array(repeating: 0, count: 12)

        for orderList in originalOrderList {
            let month = getMonthByTimeStamp(timeStamp: orderList.createTime)
            revenueOfMonth[month] += orderList.totalAmount
        }
        
        return BGMonthRevenueBarChartFactory(monthsRevenueArray: revenueOfMonth).chartDataSet
    }
    
    func getMonthByTimeStamp(timeStamp: Double) -> Int {
        let date = Date(timeIntervalSince1970: timeStamp)

        return Calendar.current.component(.month, from: date)
    }
    
    func dataChangeEvent(databaseOrders: Array<Order>) {}
    func todayDataChangeEvent(databaseOrders: Array<Order>) {}
}

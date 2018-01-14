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
        databaseAPI.getTodayOrderList { (orderList, error) in
            callback(BGBarChartConvert(bgSetArray: self.processOrderList(originalOrderList: orderList!), valueUnit: .DollarUnit), nil)
        }
//        databaseAPI.getOrderListByTimeRange(startTimeStamp: TimeFormate().getTodayTimeStamp(),
//                                            endTimeStamp:  TimeFormate().getTodayTimeStamp()) { (orderList, error) in
//        
//                                                
//        }
    }
    
    private func processOrderList(originalOrderList: Array<Order>) -> [BGBarChartDataSet]{
        var tempAllItemID: [String] = []
        for orderList in originalOrderList {
            for mealStatus in orderList.mealStatusList {
                tempAllItemID.append(mealStatus.itemID!)
            }
        }
        
        print(tempAllItemID)
        return []
    }
    
    func setupData() -> [BGBarChartDataSet] {
        return [BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 30, name: "A"),
                                              BGBarChartEntry.init(value: 125, name: "D")], title: "Q"),
                
                 BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 99, name: "E"),
                                               BGBarChartEntry.init(value: 333, name: "F")], title: "乙"),
                 
                 BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 1, name: "G"),
                                               BGBarChartEntry.init(value: 25, name: "H"),
                                               BGBarChartEntry.init(value: 83, name: "I")], title: "丙")]

    }
    
    func dataChangeEvent(databaseOrders: Array<Order>) {}
    func todayDataChangeEvent(databaseOrders: Array<Order>) {}
}

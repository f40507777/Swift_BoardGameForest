//
//  RandomDBData.swift
//  BoardGameForest
//
//  Created by Finn on 2018/2/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class RandomDBData: NSObject {
    
    let nearlyYear = 4
    
    let mealStatuslistMaxCount = 8
    
    let mealStatuslistMinCount = 1
    
    lazy var meals = MenuParser().mealArray

    lazy var databaseAPI = DatabaseAPI()

    init(orderCount: Int) {
        super.init()

        initOrders(count: orderCount)
    }
    
    func initOrders(count: Int) {
        var orderListDictionary: [String : Order] = [:]
        for _ in 1...count {
            let order = getRandomOrderData()
            order.createTime = getRandomCreateTimeStamp()
            orderListDictionary[order.orderID] = order
        }
        postRandomOrder(orderListDictionary: orderListDictionary)
    }
    
    func getRandomOrderData() -> Order {
        var mealStatusList: [MealStatus] = []
        let mealStatusListCount = Int(arc4random_uniform(UInt32(mealStatuslistMaxCount))) + mealStatuslistMinCount
        let tableNumber = TableNumber(rawValue: "C2") //hard code
        for _ in 0...mealStatusListCount {
            mealStatusList.append(getRandomMealStatus())
        }

        return Order(meals: mealStatusList, table: tableNumber!)
    }
    
    func getRandomMealStatus() -> MealStatus {
        var mergeArray: [MealStatus] = []
        for mealArray in meals {
            mergeArray += mealArray
        }
        let randomIndex = Int(arc4random_uniform(UInt32(mergeArray.count)))
        
        return mergeArray[randomIndex]
    }
    
    func getRandomCreateTimeStamp() -> Double {
        let currentTimeStamp = TimeFormate().getNearlyYearsTimeStamp(year: -1)
        let firstTimeStamp = TimeFormate().getNearlyYearsTimeStamp(year: 0)
        let timeStampOffset = currentTimeStamp - firstTimeStamp

        return drand48() * timeStampOffset + firstTimeStamp
    }
    
    func postRandomOrder(orderListDictionary : [String : Order]) {
        databaseAPI.updateOrderListDictionary(orderListDictionary: orderListDictionary)
    }
}

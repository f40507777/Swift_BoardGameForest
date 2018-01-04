//
//  tempOrder.swift
//  BoardGameForest
//
//  Created by Finn on 2017/8/30.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit
import ObjectMapper
import Firebase

enum OrderStatus: Int {
    case 未出餐
    case 已出餐
    case 已離開
}

class Order: Mappable {
    
    var orderID: String = ""
    var createTime: Double = 0
    var status: OrderStatus?
    var tableNumber: String = ""
    var totalAmount: Int = 0
    var mealStatusList: Array<MealStatus> = []

    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    init(meals: [MealStatus], table: TableNumber) {
        orderID = Database.database().reference().childByAutoId().key
        createTime = Date().timeIntervalSince1970
        status = .未出餐
        tableNumber = table.rawValue
        mealStatusList = meals
        totalAmount = calculationTotalAmount()
    }
    
    func mapping(map: Map) {
        orderID         <- map[DTORDERID]
        createTime      <- map[DTCREATETIME]
        status          <- map[DTSTATIUS]
        tableNumber     <- map[DTTABLENUMBER]
        totalAmount     <- map[DTTOTALAMOUNT]
        mealStatusList  <- map[DTMEALSTATUSLIST]
    }
    
    private func calculationTotalAmount() -> Int {

        return mealStatusList.map({$0.price}).reduce(0){($0 + $1)}
    }
}

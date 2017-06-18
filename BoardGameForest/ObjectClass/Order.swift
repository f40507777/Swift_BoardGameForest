//
//  Order.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit
import Firebase

class Order: NSObject {
//    lazy var createTime: String = {
//        let date = Date()
//        let inFormatter = DateFormatter()
//        inFormatter.locale = NSLocale(localeIdentifier: "zh_TW") as Locale!
//        inFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        
//        return inFormatter.string(from: date)
//    }()

    var createTime: TimeInterval?
    
    var totalAmount: Int = 0
    
    var mealsList: [Dictionary<String, Bool>] = []
    
    var tableNumber: TableNumber?
    
    private var orderMeals: [Meal] = []

    override init() {
        super.init()
    }
    
    init(meals: [Meal], table: TableNumber) {
        super.init()
        
        orderMeals = meals
        mealsList = getMealsList()
        totalAmount = calculationTotalAmount() - comboDiscount()
        tableNumber = table
    }
    
    init(orderDic: Dictionary<String, Any>) {
        super.init()
        
        createTime = orderDic["createTime"] as? TimeInterval
        totalAmount = orderDic["totalAmount"] as! Int
        mealsList = orderDic["mealsList"] as! [Dictionary<String, Bool>]
        tableNumber = TableNumber(rawValue: orderDic["tableNumber"] as! String)
    }

    func getDictionary() -> Dictionary<String, Any> {
        
        return [DBCREATETIME: Date().timeIntervalSince1970,
                DBTOTALAMOUNT: totalAmount,
                DBMEALSLIST: mealsList,
                DBTABLENUMBER: tableNumber!.rawValue]
    }
    
    private func getMealsList() -> [Dictionary<String, Bool>] {
        var tempList: [Dictionary<String, Bool>] = []
        for mealName in orderMeals.map({$0.name!}) {
            tempList.append([mealName:false])
        }
        
        return tempList
    }
    
    private func calculationTotalAmount() -> Int {
        return orderMeals.map({$0.price}).reduce(0){($0 + $1)}
    }

    private func comboDiscount() -> Int {
        let dessertMealCount = orderMeals.filter({$0.type == MealType.Dessert.rawValue}).count
        let notDessertMealCount = orderMeals.count - dessertMealCount
        
        return min(dessertMealCount, notDessertMealCount) * 20
    }
}

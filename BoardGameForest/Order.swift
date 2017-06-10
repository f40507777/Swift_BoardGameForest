//
//  Order.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class Order: NSObject {
    var createTime: String?
    var totalAmount: Int = 0
    var mealName: [String] = []
    var isComboDiscount = true
    private var orderMeals: [Meal] = []

    override init() {
        super.init()
    }
    
    init(meals: [Meal]) {
        super.init()
        
        orderMeals = meals
        mealName = meals.map({$0.name!})
        totalAmount = calculationTotalAmount() - comboDiscount()
    }

    private func calculationTotalAmount() -> Int {
        return orderMeals.map({$0.price}).reduce(0){($0 + $1)}
    }

    private func comboDiscount() -> Int {
        if isComboDiscount {
            let dessertMealCount = orderMeals.filter({$0.type == MealType.Dessert.rawValue}).count
            let notDessertMealCount = orderMeals.count - dessertMealCount
        
            return min(dessertMealCount, notDessertMealCount) * 20
        }
        
        return 0
    }
}

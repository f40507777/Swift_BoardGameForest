//
//  ItemManager.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class MenuParser: NSObject {
    lazy var mealArray: [[MealStatus]] = {
        var mealDynomicArray: [[MealStatus]] = []
        if let path = Bundle.main.path(forResource: "Menu", ofType: "plist") {
            for mealTypes in NSArray(contentsOfFile: path) as! Array<Array<Dictionary<String, Any>>> {
                var mealTypesDynomicArray: [MealStatus] = []
                for mealDictionary in mealTypes {
                    let meal = MealStatus()
                    meal.name = mealDictionary["name"] as? String
                    meal.price = mealDictionary["price"] as! Int
                    meal.type = mealDictionary["type"] as? Int
                    meal.itemID = mealDictionary["itemID"] as? String
                    meal.aka = mealDictionary["aka"] as? String
                    meal.isSendOut = false
                    mealTypesDynomicArray.append(meal)
                }
                mealDynomicArray.append(mealTypesDynomicArray)
            }
        }
        
        return mealDynomicArray
    }()

}

//
//  ItemManager.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class MenuParser: NSObject {
    lazy var mealArray: [[Meal]] = {
        var mealDynomicArray: [[Meal]] = []
        if let path = Bundle.main.path(forResource: "Menu", ofType: "plist") {
            for mealTypes in NSArray(contentsOfFile: path) as! Array<Array<Dictionary<String, Any>>> {
                var mealTypesDynomicArray: [Meal] = []
                for mealDictionary in mealTypes {
                    let meal = Meal()
                    meal.name = mealDictionary["name"] as! String
                    meal.price = mealDictionary["price"] as! Int
                    meal.type = mealDictionary["type"] as! Int
                    mealTypesDynomicArray.append(meal)
                }
                mealDynomicArray.append(mealTypesDynomicArray)
            }
        }
        
        return mealDynomicArray
    }()

}

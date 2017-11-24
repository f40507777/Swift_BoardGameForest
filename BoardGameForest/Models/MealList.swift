//
//  MealList.swift
//  BoardGameForest
//
//  Created by Finn on 2017/11/24.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class MealList: NSObject {

    var mealDictionary: [String : Int] = [:]
    
    func add(mealStatus: MealStatus) {
        if let count = mealDictionary[mealStatus.name!] {
            mealDictionary[mealStatus.name!] = count + 1
        } else {
            mealDictionary[mealStatus.name!] = 1
        }
    }
    
    func remove(mealStatus: MealStatus) {
        if let count = mealDictionary[mealStatus.name!] {
            if count > 0 {
                mealDictionary[mealStatus.name!] = count - 1
            }
        } else {
            mealDictionary[mealStatus.name!] = 0
        }
    }
    
    func count(mealStatus: MealStatus) -> Int {
        if let count = mealDictionary[mealStatus.name!] {
            return count
        }
        
        return 0
    }
}

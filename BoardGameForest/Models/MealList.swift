//
//  MealList.swift
//  BoardGameForest
//
//  Created by Finn on 2017/11/24.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class MealList: NSObject {
    
    var array: [MealStatus] = []

    func add(mealStatus: MealStatus) {
        self.array.append(mealStatus)
    }
    
    func remove(mealStatus: MealStatus) {
        
        let mealsNameArray = self.array.map { (mealStatus) -> String in
            return mealStatus.name!
        }
        
        if let index = mealsNameArray.index(of: mealStatus.name!) {
            self.array.remove(at: index)
        }
    }
    
    func count(mealStatus: MealStatus) -> Int {
        let filterArray = self.array.filter { (meal) -> Bool in
            meal.name == mealStatus.name
        }
        
        return filterArray.count
    }
}

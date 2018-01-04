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
    
    func isOverSet() -> Bool {
        let beverageCourseCount = self.array.filter({$0.type == MealType.Beverage.rawValue}).count
        let dessertCount = self.array.filter({
            //need to filter 炸物拼盤
            $0.type == MealType.Dessert.rawValue &&
            $0.itemID != "d08"
        }).count
        let mainCourseCount = self.array.filter({$0.type == MealType.MainCourse.rawValue}).count
        let setCount = self.array.filter({$0.type == MealType.Set.rawValue}).count

        let comboGroupCount = min(beverageCourseCount + mainCourseCount, dessertCount)
        
        return setCount > comboGroupCount
    }
}

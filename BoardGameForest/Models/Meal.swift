//
//  Item.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

enum MealType: Int {
    case Beverage
    case Dessert
    case MainCourse
}

class Meal: NSObject {
    var name: String?
    var price: Int = 0
    var type: Int?
}

//
//  Item.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

enum ItemType: Int {
    case Beverage
    case Dessert
    case MainCourse
}

class Item: NSObject {
    var name: String = ""
    var price: Int = 0
    var serialNumber: String = ""
    var type: Int = 0
}

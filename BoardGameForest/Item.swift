//
//  Item.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

enum ItemType: NSInteger {
    case Beverage
    case Dessert
    case MainCourse
}

class Item: NSObject {
    var name: String?
    var price: NSInteger?
    var serialNumber: String?
    var type: NSInteger?
}

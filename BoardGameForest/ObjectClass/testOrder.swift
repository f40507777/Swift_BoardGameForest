//
//  testOrder.swift
//  BoardGameForest
//
//  Created by Finn on 2017/8/29.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class testOrder: FIRDataObject {
    var createTime: NSNumber?
    var status = 0
    var tableNumber = ""
    var totalAmount = 0
    var mealsList: Array<OrderList>?
}

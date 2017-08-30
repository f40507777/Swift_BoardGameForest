//
//  tempOrder.swift
//  BoardGameForest
//
//  Created by Finn on 2017/8/30.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class tempOrder: FIRDataObject {
    var orderID: String = ""
    var createTime: NSNumber = 0
    var status: Int = 0
    var tableNumber: Int = 0
    var totalAmount: Int = 0
    var mealStatusList: Array<tempMealStatus> = []
}

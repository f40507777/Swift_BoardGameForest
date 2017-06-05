//
//  Order.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class Order: NSObject {
    var createTime: String = ""
    var totalAmount: Int = 0
    var itemsName: NSArray = []
    
    init(items: [Item]) {
        super.init()
        
        itemsName = (items as NSArray).value(forKeyPath: "name") as! NSArray
        totalAmount = calculationTotalByItems(items: items)
    }
    
    func calculationTotalByItems(items: [Item]) -> Int {
        for item:Item in items {
            totalAmount += item.price
        }
        
        return totalAmount
    }
}

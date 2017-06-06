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
    var itemsName: [String] = []
    var isComboDiscount = true
    private var orderItems: [Item] = []

    override init() {
        super.init()
    }
    
    init(items: [Item]) {
        super.init()
        
        orderItems = items
        itemsName = ((items as NSArray).value(forKeyPath: "name") as! NSArray) as! [String]
        totalAmount = calculationTotalAmount() - comboDiscount()
    }
    
    private func calculationTotalAmount() -> Int {
        for item:Item in orderItems {
            totalAmount += item.price
        }
        
        return totalAmount
    }
    
    private func comboDiscount() -> Int {
        if isComboDiscount {
            let dessertItemPredicate = NSPredicate(format: "type = %d", ItemType.Dessert.rawValue)
            let dessertItems = (orderItems as NSArray).filtered(using: dessertItemPredicate)
            let minimum  = min(dessertItems.count, orderItems.count - dessertItems.count)
            
            return minimum * 20
        }
        
        return 0
    }
}

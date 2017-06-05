//
//  BGFDatabaseAPI.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/5.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase

class BGFDatabaseAPI: NSObject {

    static var databaseReference = Database.database().reference()

    static func addOrder(order: Order) {
        self.databaseReference.child("orders").childByAutoId().setValue(["createTime": convertDateFormater(),
                                                                         "totalAmount": order.totalAmount,
                                                                         "items": order.itemsName])
    }
    
    static func convertDateFormater() -> String {
        let date = Date()
        let inFormatter = DateFormatter()
        inFormatter.locale = NSLocale(localeIdentifier: "zh_TW") as Locale!
        inFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return inFormatter.string(from: date)
    }
}

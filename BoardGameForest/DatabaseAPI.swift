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

protocol DatabaseAPIDelegate: class {
    func dataChangeEvent(databaseOrders: Array<Order>)
}

class DatabaseAPI: NSObject {

    lazy var databaseReference = Database.database().reference()

    weak var delegate: DatabaseAPIDelegate?
    
    override init() {
        super.init()
        
        addDBObserve()
    }
    
    
    func addOrder(order: Order) {
        self.databaseReference.child("orders").childByAutoId().setValue(["createTime": convertDateFormater(),
                                                                         "totalAmount": order.totalAmount,
                                                                         "items": order.itemsName])
    }
    
    func addDBObserve() {
        self.databaseReference.child("orders").observe(DataEventType.value, with: { (snapshot) in
            self.delegate?.dataChangeEvent(databaseOrders: self.convertServerDataToItemArray(snapshot: snapshot))
        })
    }
    
    func getAllOrdersArray(callback: @escaping (Array<Order>?, Error?) -> Void) {
        self.databaseReference.child("orders").observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.convertServerDataToItemArray(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }

    }
    
    func hackLogin (){
        Auth.auth().signIn(withEmail: "f40507777@gmail.com", password: "123456") { (user, error) in
            if error == nil {
                print("success")
            } else {
                print("error")
            }
        }
    }
    
    func convertServerDataToItemArray(snapshot: DataSnapshot) -> Array<Order> {
        var orderArray:Array<Order> = Array()
        let ordersDictionary = snapshot.value as? NSDictionary
        let ordersValueArray = ordersDictionary!.allValues as! Array<NSDictionary>
        for order in ordersValueArray {
            let newOrder = Order()
            newOrder.createTime = order["createTime"] as! String
            newOrder.totalAmount = order["totalAmount"] as! Int
            newOrder.itemsName = (order["items"] as! NSArray) as! [String]
            orderArray.append(newOrder)
        }
        
        return orderArray
    }
    
    func convertDateFormater() -> String {
        let date = Date()
        let inFormatter = DateFormatter()
        inFormatter.locale = NSLocale(localeIdentifier: "zh_TW") as Locale!
        inFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return inFormatter.string(from: date)
    }
    
    
}

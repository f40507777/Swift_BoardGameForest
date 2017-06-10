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

    private lazy var databaseOrderPath = Database.database().reference().child("orders")

    weak var delegate: DatabaseAPIDelegate?
    
    override init() {
        super.init()
        
        addDBObserve()
    }
    
    
    func addOrder(order: Order) {
        databaseOrderPath.childByAutoId().setValue(["createTime": convertDateFormater(),
                                                                         "totalAmount": order.totalAmount,
                                                                         "items": order.mealName])
    }
    
    func addDBObserve() {
        databaseOrderPath.observe(DataEventType.value, with: { (snapshot) in
            self.delegate?.dataChangeEvent(databaseOrders: self.convertServerDataToItemArray(snapshot: snapshot))
        })
    }
    
    func getAllOrdersArray(callback: @escaping (Array<Order>?, Error?) -> Void) {
        databaseOrderPath.observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.convertServerDataToItemArray(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }
    }
    
    func clearAllData() {
        databaseOrderPath.setValue(nil)
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
        if let ordersValueArray = ordersDictionary?.allValues as? Array<NSDictionary> {
            for order in ordersValueArray {
                let newOrder = Order()
                newOrder.createTime = order["createTime"] as? String
                newOrder.totalAmount = order["totalAmount"] as! Int
                newOrder.mealName = (order["items"] as! NSArray) as! [String]
                orderArray.append(newOrder)
            }
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

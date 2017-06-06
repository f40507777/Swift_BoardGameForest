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
    func dataChangeEvent(callback: Array<Order>)
}

class BGFDatabaseAPI: NSObject {

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
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            self.delegate?.dataChangeEvent()
        })
    }
    
    func getAllOrdersArray(callback: @escaping (Array<Order>?, Error?) -> Void) {
        
        var orderArray:Array<Order> = Array()
        self.databaseReference.child("orders").observeSingleEvent(of: .value, with: { (snapshot) in
            let ordersDic = snapshot.value as? NSDictionary
            let orders = ordersDic!.allValues as NSArray
            for order in orders {
                let newOrder = Order()
                newOrder.createTime = (order as! NSDictionary)["createTime"] as! String
                newOrder.totalAmount = (order as! NSDictionary)["totalAmount"] as! Int
                newOrder.itemsName = ((order as! NSDictionary)["items"] as! NSArray) as! [String]
                orderArray.append(newOrder)
            }
            callback(orderArray, nil)
        }) { (error) in
            callback(nil, error)
        }

    }
    
//    func readOrders(onCompletion: ServiceResponse) -> Array<Order> {
//        var orderArray:Array<Order> = Array()
//
//        self.databaseReference.child("orders").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            let ordersDic = snapshot.value as? NSDictionary
//            let orders = ordersDic!.allValues as NSArray
//            
//            for order in orders {
//                let newOrder = Order()
//                newOrder.createTime = (order as! NSDictionary)["createTime"] as! String
//                newOrder.totalAmount = (order as! NSDictionary)["totalAmount"] as! Int
//                newOrder.itemsName = ((order as! NSDictionary)["items"] as! NSArray) as! [String]
//                orderArray.append(newOrder)
//            }
//            
//        }) { (error) in
//        }
//        
//        
//        return orderArray
//    }
    
    func hackLogin (){
        Auth.auth().signIn(withEmail: "f40507777@gmail.com", password: "123456") { (user, error) in
            if error == nil {
                print("success")
            } else {
                print("error")
            }
        }
    }
    
    func convertDateFormater() -> String {
        let date = Date()
        let inFormatter = DateFormatter()
        inFormatter.locale = NSLocale(localeIdentifier: "zh_TW") as Locale!
        inFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return inFormatter.string(from: date)
    }
    
}

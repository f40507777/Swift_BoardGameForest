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
    func dataChangeEvent(databaseOrders: Dictionary<String, Order>)
}

class DatabaseAPI: NSObject {

    private lazy var databaseOrderPath = Database.database().reference().child("orders")

    weak var delegate: DatabaseAPIDelegate?
    
    override init() {
        super.init()
        
        addDBObserve()
    }
    
    
    func addOrder(order: Order) {
        databaseOrderPath.childByAutoId().setValue(order.getDictionary())
    }
    
    func addDBObserve() {
        databaseOrderPath.observe(DataEventType.value, with: { (snapshot) in
            self.delegate?.dataChangeEvent(databaseOrders: self.convertServerDataToOrderDictionary(snapshot: snapshot))
        })
    }
    
    func updateMealsList(orderID: String, mealsList: [Dictionary<String, Bool>]) {
        databaseOrderPath.child(orderID).child("mealsList").setValue(mealsList)
    }
    
    func getAllOrdersDictionary(callback: @escaping (Dictionary<String, Order>?, Error?) -> Void) {
        databaseOrderPath.observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.convertServerDataToOrderDictionary(snapshot: snapshot), nil)
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
    
    private func convertServerDataToOrderDictionary(snapshot: DataSnapshot) -> Dictionary<String, Order> {
        var ordersDictionary: Dictionary<String, Order> = [:]
        if let snapshotDic = (snapshot.value as? Dictionary<String, Dictionary<String, Any>>) {
            for orderDic in snapshotDic {
                ordersDictionary[orderDic.key] = Order(orderDic: orderDic.value)
            }
        }

        return ordersDictionary
    }
}

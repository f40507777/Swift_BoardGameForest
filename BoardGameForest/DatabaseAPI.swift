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
    
    func todayDataChangeEvent(databaseOrders: Dictionary<String, Order>)
}

extension DatabaseAPIDelegate {
    func dataChangeEvent(databaseOrders: Dictionary<String, Order>) {
        
    }
}

let DBORDER: String = "orders"

let DBMEALSLIST: String = "mealsList"

let DBCREATETIME: String = "createTime"

let DBTOTALAMOUNT: String = "totalAmount"

let DBTABLENUMBER: String = "tableNumber"

let DBSTATIUS: String = "status"

class DatabaseAPI: NSObject {

    private lazy var databaseOrderPath = Database.database().reference().child(DBORDER)

    weak var delegate: DatabaseAPIDelegate?
    
    override init() {
        super.init()
        
        addDBObserve()
        addTodayDBObserve()
    }

    
    func addOrder(order: Order) {
        databaseOrderPath.childByAutoId().setValue(order.getDictionary())
    }
    
    func addDBObserve() {
        databaseOrderPath.observe(DataEventType.value, with: { (snapshot) in
            self.delegate?.dataChangeEvent(databaseOrders: self.convertServerDataToOrderDictionary(snapshot: snapshot))
        })
    }
    
    func addTodayDBObserve() {
        databaseOrderPath.queryOrdered(byChild: DBCREATETIME).queryStarting(atValue: TimeFormate().getTodayTimeStamp()).observe(DataEventType.value, with: { (snapshot) in
            self.delegate?.todayDataChangeEvent(databaseOrders: self.convertServerDataToOrderDictionary(snapshot: snapshot))
        })
    }
    
    func updateMealsList(orderID: String, mealsList: [Dictionary<String, Bool>]) {
        databaseOrderPath.child(orderID).child(DBMEALSLIST).setValue(mealsList)
    }
    
    func updateOrderFinish(orderID: String, orderStatus: OrderStatus) {
        databaseOrderPath.child(orderID).child(DBSTATIUS).setValue(orderStatus.rawValue)
    }
    
    func getAllOrdersDictionary(callback: @escaping (Dictionary<String, Order>?, Error?) -> Void) {
        databaseOrderPath.observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.convertServerDataToOrderDictionary(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }
    }
    
    func getTodayOrdersDictionary(callback: @escaping (Dictionary<String, Order>?, Error?) -> Void) {
        databaseOrderPath.queryOrdered(byChild: DBCREATETIME).queryStarting(atValue: TimeFormate().getTodayTimeStamp()).observeSingleEvent(of: .value, with: { (snapshot) in
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

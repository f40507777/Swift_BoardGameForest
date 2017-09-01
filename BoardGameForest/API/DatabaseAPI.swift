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
import ObjectMapper

protocol DatabaseAPIDelegate: class {
    
    func dataChangeEvent(databaseOrders: Array<Order>)
    
    func todayDataChangeEvent(databaseOrders: Array<Order>)
}

extension DatabaseAPIDelegate {
    func dataChangeEvent(databaseOrders: Dictionary<String, Order>) {
        
    }
}

class DatabaseAPI: NSObject {

    private lazy var databaseOrderPath = Database.database().reference().child(DTORDERLIST)

    weak var delegate: DatabaseAPIDelegate?
    
    override init() {
        super.init()
        
        addDBObserve()
        addTodayDBObserve()
    }

    

    
    func addDBObserve() {
        databaseOrderPath.observe(DataEventType.value, with: { (snapshot) in
            self.delegate?.dataChangeEvent(databaseOrders: self.getOrderListBySnapshot(snapshot: snapshot))
        })
    }
    
    func updateOrder(order: Order) {
        databaseOrderPath.child(order.orderID).setValue(order.toJSON())
    }
    
    func addTodayDBObserve() {
        databaseOrderPath.queryOrdered(byChild: DTCREATETIME).queryStarting(atValue: TimeFormate().getTodayTimeStamp()).observe(DataEventType.value, with: { (snapshot) in
            let orderList = Mapper<OrderList>().map(JSON: [snapshot.key : snapshot.value as Any])
            self.delegate?.todayDataChangeEvent(databaseOrders: (orderList?.list)!)
        })
        
    }
    
    func updateMealsList(orderID: String, mealStatusList: Array<MealStatus>) {
        databaseOrderPath.child(orderID).child(DTORDERLIST).setValue(mealStatusList.toJSON())
    }
    
    func updateOrderFinish(orderID: String, orderStatus: OrderStatus) {
        databaseOrderPath.child(orderID).child(DTSTATIUS).setValue(orderStatus.rawValue)
    }
    
    func getAllOrderList(callback: @escaping (Array<Order>?, Error?) -> Void) {
        databaseOrderPath.observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.getOrderListBySnapshot(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }
    }
    
    
    func getTodayOrdersDictionary(callback: @escaping (Array<Order>?, Error?) -> Void) {
        databaseOrderPath.queryOrdered(byChild: DTCREATETIME).queryStarting(atValue: TimeFormate().getTodayTimeStamp()).observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.getOrderListBySnapshot(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }
    }
    
    func clearAllData() {
        databaseOrderPath.setValue(nil)
    }
    
    func hackLogin() {
        Auth.auth().signIn(withEmail: "f40507777@gmail.com", password: "123456") { (user, error) in
            if error == nil {
                print("success")
            } else {
                print("error")
            }
        }
    }
    
    private func getOrderListBySnapshot(snapshot :DataSnapshot) -> Array<Order>{
        let orderList:OrderList = Mapper<OrderList>().map(JSON: [snapshot.key : snapshot.value as Any])!

        return orderList.list
    }
}

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
    
    // MARK: - Update

    func updateOrder(order: Order) {
        databaseOrderPath.child(order.orderID).setValue(order.toJSON())
    }
    
    
    // MARK: - Get

    func getAllOrderList(callback: @escaping (Array<Order>?, Error?) -> Void) {
        databaseOrderPath.observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.getOrderListBySnapshot(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }
    }
    
    func getTodayOrderList(callback: @escaping (Array<Order>?, Error?) -> Void) {
        databaseOrderPath.queryOrdered(byChild: DTCREATETIME).queryStarting(atValue: TimeFormate().getTodayTimeStamp()).observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.getOrderListBySnapshot(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }
    }
    
    func getYearOrderList(callback: @escaping (Array<Order>?, Error?) -> Void) {
        databaseOrderPath.queryOrdered(byChild: DTCREATETIME).queryStarting(atValue: TimeFormate().getYearTimeStamp()).observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.getOrderListBySnapshot(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }
    }
    
    func getYearsOrderList(callback: @escaping (Array<Order>?, Error?) -> Void) {
        databaseOrderPath.queryOrdered(byChild: DTCREATETIME).queryStarting(atValue: TimeFormate().getYearTimeStamp()).observeSingleEvent(of: .value, with: { (snapshot) in
            callback(self.getOrderListBySnapshot(snapshot: snapshot), nil)
        }) { (error) in
            callback(nil, error)
        }
    }
    
    func getOrderListByTimeRange(startTimeStamp: TimeInterval, endTimeStamp: TimeInterval, callback: @escaping (Array<Order>?, Error?) -> Void) {
        databaseOrderPath.queryOrdered(byChild: DTCREATETIME).queryStarting(atValue: startTimeStamp).queryEnding(atValue: endTimeStamp).observe(DataEventType.value) { (snapshot) in
            
            callback(self.getOrderListBySnapshot(snapshot: snapshot), nil)
        }
    }
    // MARK: - Public

    func hackLogin() {
        Auth.auth().signIn(withEmail: "f40507777@gmail.com", password: "123456") { (user, error) in
            if error == nil {
                print("login success")
            } else {
                print("login failed")
            }
        }
    }
    
    func clearAllData() {
        databaseOrderPath.setValue(nil)
    }
    
    // MARK: - Private

    private func addDBObserve() {
        databaseOrderPath.observe(DataEventType.value, with: { (snapshot) in
            self.delegate?.dataChangeEvent(databaseOrders: self.getOrderListBySnapshot(snapshot: snapshot))
        })
    }
    
    private func addTodayDBObserve() {
        databaseOrderPath.queryOrdered(byChild: DTCREATETIME).queryStarting(atValue: TimeFormate().getTodayTimeStamp()).observe(DataEventType.value, with: { (snapshot) in
            let orderList = Mapper<OrderList>().map(JSON: [snapshot.key : snapshot.value as Any])
            self.delegate?.todayDataChangeEvent(databaseOrders: (orderList?.list)!)
        })
        
    }

    
    private func getOrderListBySnapshot(snapshot :DataSnapshot) -> Array<Order>{
        let orderList:OrderList = Mapper<OrderList>().map(JSON: [snapshot.key : snapshot.value as Any])!

        return orderList.list
    }
}

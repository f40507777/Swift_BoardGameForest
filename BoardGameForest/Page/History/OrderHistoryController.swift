//
//  OrderHistoryController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/9/1.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class OrderHistoryController: UITableViewController, DatabaseAPIDelegate {

    lazy var databaseAPI = DatabaseAPI()
    
    var orderList: Array<Order> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
    }

    func initData() {
        databaseAPI.delegate = self
        databaseAPI.getAllOrderList { (allOrderList, error) in
            self.refreshOrderList(originalOrderList: allOrderList!)
        }
    }
    
    private func refreshOrderList(originalOrderList: Array<Order>) {
        orderList = originalOrderList.filter{$0.status == .未出餐}
        self.tableView.reloadData()
    }
    
    // MARK: - TableViewDelegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return orderList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList[section].mealStatusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        let meal = orderList[indexPath.section].mealStatusList[indexPath.row]
        cell.textLabel?.text = meal.name
        cell.accessoryType = meal.isSendOut! ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return orderList[section].tableNumber
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let order = orderList[indexPath.section]
        order.mealStatusList[indexPath.row].isSendOut = !order.mealStatusList[indexPath.row].isSendOut!
        if isAllMealsFinish(mealStatus: order.mealStatusList) {
            order.status = .已出餐
        }
        databaseAPI.updateOrder(order: order)
    }
    
    // MARK: - DatabaseAPIDelegate
    func dataChangeEvent(databaseOrders: Array<Order>) {
        
    }
    
    func todayDataChangeEvent(databaseOrders: Array<Order>) {
        refreshOrderList(originalOrderList: databaseOrders)
    }
    
    private func isAllMealsFinish(mealStatus: Array<MealStatus>) -> Bool{
        return mealStatus.filter{$0.isSendOut == true}.count == mealStatus.count
    }
}

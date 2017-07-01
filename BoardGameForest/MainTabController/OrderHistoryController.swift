//
//  OrderHistoryController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/6.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class OrderHistoryController: UITableViewController,DatabaseAPIDelegate {

    lazy var databaseAPI = DatabaseAPI()

    var ordersDictionary: Dictionary<String, Order> = [:]
    
    var oidArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDatabase()
    }
    
    func initDatabase() {
        databaseAPI.delegate = self
        databaseAPI.getTodayOrdersDictionary { databaseOrders, error in
            if (error == nil) {
                self.refreshData(dataOrders: databaseOrders!)
            }
        }
    }
    
    func refreshData(dataOrders: Dictionary<String, Order>) {
        ordersDictionary = dataOrders
        oidArray = Array(self.ordersDictionary.keys)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return oidArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (ordersDictionary[oidArray[section]]?.mealsList.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        let meal = ordersDictionary[oidArray[indexPath.section]]?.mealsList[indexPath.row]
        cell.textLabel?.text = meal?.keys.first
        cell.accessoryType = (meal?.values.first)! ? .checkmark : .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var mealsList = ordersDictionary[oidArray[indexPath.section]]?.mealsList
        mealsList?[indexPath.row] = [(mealsList?[indexPath.row].keys.first)! : !(mealsList?[indexPath.row].values.first)!]
        databaseAPI.updateMealsList(orderID: oidArray[indexPath.section], mealsList: mealsList!)
        if isMealsIsAllFinish(meals: mealsList!) {
            databaseAPI.updateOrderFinish(orderID: oidArray[indexPath.section], orderStatus: .已出餐)
        }

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ordersDictionary[oidArray[section]]?.tableNumber?.rawValue
    }
    
    func todayDataChangeEvent(databaseOrders: Dictionary<String, Order>) {
        refreshData(dataOrders: databaseOrders)
    }
    
    func isMealsIsAllFinish(meals: [Dictionary<String, Bool>]) -> Bool {
        return meals.filter{$0.first?.value == false}.count == 0
    }
}

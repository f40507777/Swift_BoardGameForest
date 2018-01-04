//
//  OrderMenuViewController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/5.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class OrderMenuViewController: UITableViewController {

    lazy var databaseAPI = DatabaseAPI()
    
    lazy var meals = MenuParser().mealArray
    
    var orderList = MealList()
    
    var table: Table
    
    init(table: Table) {
        self.table = table
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        setNavigationItem()
    }
    
    func initTableView() {
        tableView.register(UINib(nibName: "OrderMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderMenuTableViewCell")
    }
    
    func setNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendOrder))
        navigationItem.title = table.tableNumber?.rawValue
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return meals[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tableView.dequeueReusableCell(withIdentifier: "OrderMenuTableViewCell") as! OrderMenuTableViewCell

        let meal:MealStatus = meals[indexPath.section][indexPath.row]
        cell.nameLabel!.text = meal.name
        cell.count = orderList.count(mealStatus: meal)
        cell.addButtonTapAction = {
            self.orderList.add(mealStatus: meal)
            self.tableView.reloadData()

        }
        cell.removeButtonTapAction = {
            self.orderList.remove(mealStatus: meal)
            self.tableView.reloadData()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Title"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal:MealStatus = meals[indexPath.section][indexPath.row]
        orderList.add(mealStatus: meal)
        self.tableView.reloadData()
    }
    
    @objc func sendOrder() {
        
        if isEmptyList() || isOverSet() {
            return
        }
        
        if orderList.array.count > 0 {
            let order = Order(meals:orderList.array ,table:table.tableNumber!)
            databaseAPI.updateOrder(order: order)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func isEmptyList() -> Bool {
        if orderList.array.count == 0 {
            let noItemAlert = UIAlertController(title: "沒有餐點", message: "請至少點選一份餐點", preferredStyle: UIAlertControllerStyle.alert)
            noItemAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            present(noItemAlert, animated: true, completion: nil)
        }
        
        return orderList.array.count == 0
    }
    
    func isOverSet() -> Bool {
        if orderList.isOverSet() {
            let overSetAlert = UIAlertController(title: "套餐過多", message: "請確認是否有足夠的套餐", preferredStyle: UIAlertControllerStyle.alert)
            overSetAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            present(overSetAlert, animated: true, completion: nil)
        }
        
        return orderList.isOverSet()
    }
    
}

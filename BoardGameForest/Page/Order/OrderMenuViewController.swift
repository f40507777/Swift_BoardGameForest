//
//  OrderMenuViewController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/5.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class OrderMenuViewController: UITableViewController, OrderMenuCellDelegate {

    lazy var databaseAPI = DatabaseAPI()
    
    lazy var meals = MenuParser().mealArray
    
    var orderMealsArray: [MealStatus] = []
    
    var mealList = MealList()
    
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
        cell.delegate = self
        cell.count = mealList.count(mealStatus: meal)
        cell.addButtonTapAction = {
            self.mealList.add(mealStatus: meal)
            self.tableView.reloadData()

        }
        cell.removeButtonTapAction = {
            self.mealList.remove(mealStatus: meal)
            self.tableView.reloadData()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Title"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = meals[indexPath.section][indexPath.row]
        orderMealsArray.append(meal)
    }
    
    func sendOrder() {
        if orderMealsArray.count > 0 {
            let order = Order(meals:orderMealsArray ,table:table.tableNumber!)
            databaseAPI.updateOrder(order: order)
            navigationController?.popViewController(animated: true)
        }
        
        let noItemAlert = UIAlertController(title: "沒有餐點", message: "請至少點選一份餐點", preferredStyle: UIAlertControllerStyle.alert)
        noItemAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        present(noItemAlert, animated: true, completion: nil)

    }
    
    // MARK: OrderMenuCellDelegate
    func additionCountEvent(mealName: String) {
        
    }
    
    func subtractionCountEvent(mealName: String) {
        
    }
    
    
}

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
    
    var orderMealsArray: [MealStatus] = []

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
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        let meal = meals[indexPath.section][indexPath.row]
        cell.textLabel!.text = meal.name
        
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
        let order = Order(meals:orderMealsArray ,table:table.tableNumber!)
        databaseAPI.updateOrder(order: order)
        navigationController?.popViewController(animated: true)
    }
    
}

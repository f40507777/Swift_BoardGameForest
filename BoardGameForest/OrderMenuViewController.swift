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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendOrder))
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        let item = meals[indexPath.row]
        cell.textLabel!.text = item.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "123"
//        return ItemManager.getTypeNameArray()[section] as? String
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let item = allItems[indexPath.section][indexPath.row]
//        orderArray.append(item)
    }
    
    func sendOrder() {
//        let order = Order(items: orderArray)
//        databaseAPI.addOrder(order: order)
    }
    
}

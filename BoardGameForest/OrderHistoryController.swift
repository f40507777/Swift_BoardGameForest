//
//  OrderHistoryController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/6.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class OrderHistoryController: UITableViewController {

    lazy var databaseAPI = BGFDatabaseAPI()

    var orders: Array<Order> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseAPI.getAllOrdersArray { (ordersArray: Array<Order>?, error: Error?) in
            if (error == nil) {
                self.orders = ordersArray!
                self.tableView.reloadData()
            }
        }

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return orders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders[section].itemsName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        cell.textLabel?.text = orders[indexPath.section].itemsName[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return orders[section].createTime
    }
}

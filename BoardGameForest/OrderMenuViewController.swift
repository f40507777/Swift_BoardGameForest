//
//  OrderMenuViewController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/5.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class OrderMenuViewController: UITableViewController {

    var items: [[Item]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        proccessItems()
    }


    func proccessItems() {

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return ItemManager.getItems().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (ItemManager.getItems()[section] as! NSArray).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        let item:Item = ((ItemManager.getItems()[indexPath.section] as! NSArray)[indexPath.row] as! Item)
        
        cell.textLabel!.text = item.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return ItemManager.getTypeNameArray()[section] as? String
    }
    
}

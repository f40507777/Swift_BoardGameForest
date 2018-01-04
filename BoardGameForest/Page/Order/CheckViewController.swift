//
//  CheckViewController.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    lazy var databaseAPI = DatabaseAPI()

    var mealStatusList: MealList!
    
    var order: Order!
    
    var orderDictionary: [String : Int] = [:]

    init(meals: MealList, tableNumber: TableNumber) {
        self.mealStatusList = meals
        self.order = Order(meals:meals.array ,table:tableNumber)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        initUI()
        initData()
    }

    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CheckTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckTableViewCell")
    }
    
    func initData() {
        for mealStatus in mealStatusList.array {
            if let keyExists = orderDictionary[mealStatus.name!] {
                orderDictionary[mealStatus.name!] = keyExists + 1
            } else {
                orderDictionary[mealStatus.name!] = 1
            }
        }
    }
    
    func initUI() {
        self.totalAmountLabel.text = String(order.totalAmount)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CheckTableViewCell") as! CheckTableViewCell
        let mealName:String = Array(orderDictionary.keys)[indexPath.row]
        let amount:Int = Array(orderDictionary.values)[indexPath.row]
        cell.nameLabel.text = mealName
        cell.amountLabel.text = String(amount)
        
        return cell
    }

    @IBAction func clickDoneButton() {
        databaseAPI.updateOrder(order: order)
        navigationController?.popToRootViewController(animated: true)
    }
    
}

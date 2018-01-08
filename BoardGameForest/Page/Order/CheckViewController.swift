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
    
    lazy var fullmMeals = MenuParser().mealArray

    lazy var databaseAPI = DatabaseAPI()

    var mealStatusList: MealList!
    
    var order: Order!
    
    var orderMealNameArray: Array<String>!

    init(meals: MealList, tableNumber: TableNumber) {
        super.init(nibName: nil, bundle: nil)

        self.mealStatusList = meals
        self.orderMealNameArray = Array(Set(meals.array.map({$0.name!})))
        self.order = Order(meals:meals.array ,table:tableNumber)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        initUI()
    }

    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CheckTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckTableViewCell")
    }

    func initUI() {
        self.totalAmountLabel.text = String(order.totalAmount)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderMealNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CheckTableViewCell") as! CheckTableViewCell
        let mealName:String = orderMealNameArray[indexPath.row]
        let count:Int = mealStatusList.array.filter({$0.name! == mealName}).count
        let amount:Int = mealStatusList.array.filter({$0.name! == mealName}).map({$0.price}).reduce(0){($0 + $1)}
        cell.nameLabel.text = mealName
        cell.countLabel.text = "x " + String(count)
        cell.amountLabel.text = String(amount)
        
        return cell
    }

    @IBAction func clickDoneButton() {
        databaseAPI.updateOrder(order: order)
        navigationController?.popToRootViewController(animated: true)
    }
    
}

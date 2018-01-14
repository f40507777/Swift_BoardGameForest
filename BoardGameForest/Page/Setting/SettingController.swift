//
//  SettingController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/10.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class SettingController: UITableViewController {

    lazy var databaseAPI = DatabaseAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Setting"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "clear database"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "bar chart"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            databaseAPI.clearAllData()
        } else if indexPath.row == 1 {
            
            let testDataArray = [BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 30, name: "A"),
                                                               BGBarChartEntry.init(value: 2, name: "B"),
                                                               BGBarChartEntry.init(value: 44, name: "C"),
                                                               BGBarChartEntry.init(value: 125, name: "D")], title: "甲"),

                                 BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 99, name: "E"),
                                                               BGBarChartEntry.init(value: 333, name: "F")], title: "乙"),

                                 BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 1, name: "G"),
                                                               BGBarChartEntry.init(value: 25, name: "H"),
                                                               BGBarChartEntry.init(value: 83, name: "I")], title: "丙")]
            let convert = BGBarChartConvert(bgSetArray: testDataArray,valueUnit: ValueUnit.DollarUnit)
            let chartViewController = BarChartViewController(bgConvertData: convert)
            navigationController?.pushViewController(chartViewController, animated: true)
        }
    }
    

}

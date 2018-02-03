//
//  DataAnalysisTableViewController.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/14.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class DataAnalysisTableViewController: UITableViewController {

    var titleArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Data Analysis"
        titleArray = ["年度營收",
                      "歷年年度營收",
                      "當天單品銷售",
                      "單月單品銷售",
                      "單年單品銷售"]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        cell.textLabel?.text = titleArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            MonthsOfRevenueChartConvertData().asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.navigationController?.pushViewController(chartViewController, animated: true)
            })
            
        } else if indexPath.row == 1 {
            YearsOfRevenueChartConvertData().asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.navigationController?.pushViewController(chartViewController, animated: true)
            })
            
        } else if indexPath.row == 2 {
            AllItemSaleCountChartConvertData(nearlyDay: 1).asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.navigationController?.pushViewController(chartViewController, animated: true)
            })
            
        } else if indexPath.row == 3 {
            AllItemSaleCountChartConvertData(nearlyDay: 30).asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.navigationController?.pushViewController(chartViewController, animated: true)
            })
            
        } else if indexPath.row == 4 {
            AllItemSaleCountChartConvertData(nearlyDay: 365).asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.navigationController?.pushViewController(chartViewController, animated: true)
            })
        }
    }

}

//
//  SettingTableData.swift
//  BoardGameForest
//
//  Created by Finn on 2018/2/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class SettingTableData: NSObject {
    
    lazy var databaseAPI = DatabaseAPI()

    var sectionDataArray: [TableSectionData] = []

    var viewController: UIViewController = UIViewController()
    
    init(viewController: UIViewController) {
        super.init()
        
        self.viewController = viewController
        self.initTableData()
    }
    
    func initTableData() {
        self.sectionDataArray = [dataProcessSectionData(),
                                 dataAnalysisSectionData()]
    }

    // MARK: Section Data
    
    func dataProcessSectionData() -> TableSectionData {
        return TableSectionData(title: "資料處理",
                                cellArray: [cleanAllDBData(),
                                            createRandanDBData()])
    }
    
    func dataAnalysisSectionData() -> TableSectionData {
        return TableSectionData(title: "資料分析",
                                cellArray: [monthsOfRevenueChart(),
                                            yearsOfRevenueChart(),
                                            todayOfSaleItemCountChart(),
                                            monthOfSaleItemCountChart(),
                                            yearOfSaleItemCountChart()])
    }
    
    // MARK: Cell Data
    
    func cleanAllDBData() -> TableCellData {
        return TableCellData(title: "清除所有資料", clickAciotn: clickClearAllDataButton)
    }
    
    func createRandanDBData() -> TableCellData {
        return TableCellData(title: "隨機產生資料", clickAciotn: {
            RandomDBData(orderCount: 5)
        })
    }
    
    func monthsOfRevenueChart() -> TableCellData {
        return TableCellData(title: "整月營收報表", clickAciotn: {
            MonthsOfRevenueChartConvertData().asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.viewController.navigationController?.pushViewController(chartViewController, animated: true)
            })
        })
    }
    
    func yearsOfRevenueChart() -> TableCellData {
        return TableCellData(title: "歷年營收報表", clickAciotn: {
            YearsOfRevenueChartConvertData().asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.viewController.navigationController?.pushViewController(chartViewController, animated: true)
            })
        })
    }
    
    func todayOfSaleItemCountChart() -> TableCellData {
        return TableCellData(title: "當天單品銷售", clickAciotn: {
            AllItemSaleCountChartConvertData(nearlyDay: 1).asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.viewController.navigationController?.pushViewController(chartViewController, animated: true)
            })
        })
    }
    
    func monthOfSaleItemCountChart() -> TableCellData {
        return TableCellData(title: "單月單品銷售", clickAciotn: {
            AllItemSaleCountChartConvertData(nearlyDay: 30).asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.viewController.navigationController?.pushViewController(chartViewController, animated: true)
            })
        })
    }
    
    func yearOfSaleItemCountChart() -> TableCellData {
        return TableCellData(title: "單年單品銷售", clickAciotn: {
            AllItemSaleCountChartConvertData(nearlyDay: 365).asyncQuary(callback: { (convertData, error) in
                let chartViewController = BarChartViewController(bgConvertData: convertData!)
                self.viewController.navigationController?.pushViewController(chartViewController, animated: true)
            })
        })
    }
    
    // MARK: Cliclk Action

    func clickClearAllDataButton() {
        let cleanAlert = UIAlertController(title: "刪除", message: "是否刪除所有資料", preferredStyle: UIAlertControllerStyle.alert)
        cleanAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.databaseAPI.clearAllData()
        }))
        cleanAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.viewController.present(cleanAlert, animated: true, completion: nil)
    }
}

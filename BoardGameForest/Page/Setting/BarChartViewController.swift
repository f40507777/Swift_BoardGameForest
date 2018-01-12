//
//  BarChartViewController.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/6.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var chartView: BarChartView!
    
    var barChartData: BarChartData!

    var testDataArray:[BGBarChartEntry] = []
    
//    init(barChartData: BarChartData) {
//        self.barChartData = barChartData
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let testDataArray = [BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 30, name: "A"),
                                                           BGBarChartEntry.init(value: 2, name: "B"),
                                                           BGBarChartEntry.init(value: 44, name: "C"),
                                                           BGBarChartEntry.init(value: 125, name: "D")], title: "甲"),
                             
                             BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 99, name: "E"),
                                                           BGBarChartEntry.init(value: 333, name: "F")], title: "乙"),
                             
                             BGBarChartDataSet(entryArray:[BGBarChartEntry.init(value: 1, name: "G"),
                                                           BGBarChartEntry.init(value: 25, name: "H"),
                                                           BGBarChartEntry.init(value: 83, name: "I")], title: "丙")]
        
        
        
        chartView.data = BGBarChartCovert(bgSetArray: testDataArray).barChartData
        chartView.animate(yAxisDuration: 3)
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = (chartView.data?.entryCount)!
//        xAxis.valueFormatter = self

    }

}


//extension BarChartViewController: IAxisValueFormatter {
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return ""
//    }
//}


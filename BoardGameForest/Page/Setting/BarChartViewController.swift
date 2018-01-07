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

        testDataArray = [
            BGBarChartEntry.init(yValue: 30, xNameLabel: "A", setType: 0),
            BGBarChartEntry.init(yValue: 50, xNameLabel: "B", setType: 0),
            BGBarChartEntry.init(yValue: 10, xNameLabel: "C", setType: 0),
            BGBarChartEntry.init(yValue: 2, xNameLabel: "D", setType: 0),
            
            BGBarChartEntry.init(yValue: 15, xNameLabel: "F", setType: 1),
            BGBarChartEntry.init(yValue: 142, xNameLabel: "G", setType: 1),
            BGBarChartEntry.init(yValue: 32, xNameLabel: "H", setType: 1),

            BGBarChartEntry.init(yValue: 3, xNameLabel: "I", setType: 2),
            BGBarChartEntry.init(yValue: 13, xNameLabel: "J", setType: 2),

            BGBarChartEntry.init(yValue: 243, xNameLabel: "K", setType: 3),
            BGBarChartEntry.init(yValue: 12, xNameLabel: "L", setType: 3),
            BGBarChartEntry.init(yValue: 56, xNameLabel: "M", setType: 3)
        ]
        
        let testAdapter = BGBarChartAdapter(chartEntryArray: testDataArray, titleArray: ["first", "seconed", "third", "fourd"])
        
        
        chartView.animate(yAxisDuration: 3)
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = testAdapter.allChartEntryArray.count
        xAxis.valueFormatter = self
        
//        let objects = Array(1...3).map { (i) -> BarChartDataEntry in
//            let val: Int = i + 2
//
//            return BarChartDataEntry(x: Double(i), y: Double(val))
//        }
//
//        let set1 = BarChartDataSet(values: objects, label: "The year 2017")
//        set1.colors = [NSUIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1.0)]
//        set1.drawValuesEnabled = false
//
//        let objects2 = Array(4...5).map { (i) -> BarChartDataEntry in
//            let val: Int = i * 2
//
//            return BarChartDataEntry(x: Double(i), y: Double(val))
//        }
//
//        let set2 = BarChartDataSet(values: objects2, label: "test2")
//        set2.colors = [NSUIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1.0)]
//        set2.drawValuesEnabled = false
//
//        let data = BarChartData(dataSet: set1)
//        data.addDataSet(set2)
        let data = BarChartData()
        for barChartSet in testAdapter.chartSetArray {
            data.addDataSet(barChartSet)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
        }

        chartView.data = data
    }
    


}

extension BarChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return testDataArray[Int(value)].xNameLabel
    }
}

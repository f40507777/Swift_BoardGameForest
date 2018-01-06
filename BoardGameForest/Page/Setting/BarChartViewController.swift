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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chartView.animate(yAxisDuration: 3)
        
        let objects = Array(1...15).map { (i) -> BarChartDataEntry in
            let val: Int = i + 2
    
            return BarChartDataEntry(x: Double(i), y: Double(val))
        }
        
        let set1 = BarChartDataSet(values: objects, label: "The year 2017")
        set1.colors = ChartColorTemplates.material()
        set1.drawValuesEnabled = false
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9
        chartView.data = data
    }

}

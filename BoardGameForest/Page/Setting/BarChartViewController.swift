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
    
    var bgConvertData: BGBarChartConvert!
    
    init(bgConvertData: BGBarChartConvert) {
        self.bgConvertData = bgConvertData
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        chartView.data = bgConvertData.barChartData
        chartView.animate(yAxisDuration: 3)
        chartView.chartDescription?.text = ""
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = (chartView.data?.entryCount)!
        xAxis.valueFormatter = self
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.positiveSuffix = bgConvertData.valueUnit == .DollarUnit ? " $" : ""
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0
    }

}

extension BarChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return bgConvertData.titleList[Int(value)]
    }
}


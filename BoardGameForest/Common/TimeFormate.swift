//
//  TimeFormate.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/18.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class TimeFormate: NSObject {

    func getNearlyMonthsTimeStamp(nearlyMonth: Int) -> TimeInterval {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let calculateDate = Calendar.current.date(byAdding: Calendar.Component.month, value: -nearlyMonth, to: Calendar.current.date(from: comp)!)
        
        return (calculateDate?.timeIntervalSince1970)!
    }
    
    func getTodayTimeStamp() -> TimeInterval {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let startOfDay = Calendar.current.date(from: comp)!

        return startOfDay.timeIntervalSince1970
    }
    
    func getTommorrowTimeStamp() -> TimeInterval {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let startOfDay = Calendar.current.date(byAdding: Calendar.Component.day, value: 1, to: Calendar.current.date(from: comp)!)!
        
        return startOfDay.timeIntervalSince1970
    }
    
    func getPrettyTime(timeStamp: TimeInterval) -> String {
        let inFormatter = DateFormatter()
        inFormatter.locale = NSLocale(localeIdentifier: "zh_TW") as Locale!
        inFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return inFormatter.string(from: Date(timeIntervalSince1970: timeStamp))
    }
}

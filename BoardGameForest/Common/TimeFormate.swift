//
//  TimeFormate.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/18.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class TimeFormate: NSObject {

    static let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
    lazy var currentTime: Date = {
        return Calendar.current.date(from: TimeFormate.comp)
        }()!

    func getCurrentTimeStamp() -> TimeInterval {
        return currentTime.timeIntervalSince1970
    }
    
    func getNearlyDaysTimeStamp(day: Int) -> TimeInterval {
        let calculateDate = Calendar.current.date(byAdding: Calendar.Component.day, value: -day, to: currentTime)
        
        return (calculateDate?.timeIntervalSince1970)!
    }
    
    func getTodayTimeStamp() -> TimeInterval {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let startOfDay = Calendar.current.date(from: comp)!
        
        return startOfDay.timeIntervalSince1970
    }
    
    func getNearlyYearsTimeStamp(year: Int) -> TimeInterval {
        let calculateDate = Calendar.current.date(byAdding: Calendar.Component.year, value: -year, to: currentTime)
        
        return (calculateDate?.timeIntervalSince1970)!
    }
    
    func getYearTimeStamp() -> TimeInterval {
        let comp: DateComponents = Calendar.current.dateComponents([.year], from: Date())
        let startOfDay = Calendar.current.date(from: comp)!
        
        return startOfDay.timeIntervalSince1970
    }
    
    func getTodayWorkTimeStamp() -> TimeInterval {
        //營業時間. 假設現在是下午三點,則回傳今日中午十二點, 假設現在時間為凌晨十二點到中午十二點,則回傳昨天中午十二點
        let hour = Calendar.current.component(.hour, from: Calendar.current.date(from: TimeFormate.comp)!)
        if (hour < 12) {
            return Calendar.current.date(byAdding: Calendar.Component.day, value: -1, to: currentTime)!.timeIntervalSince1970
        }

        return Calendar.current.date(bySetting: Calendar.Component.hour, value: 12, of: currentTime)!.timeIntervalSince1970
    }
    
    func getPrettyTime(timeStamp: TimeInterval) -> String {
        let inFormatter = DateFormatter()
        inFormatter.locale = NSLocale(localeIdentifier: "zh_TW") as Locale!
        inFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return inFormatter.string(from: Date(timeIntervalSince1970: timeStamp))
    }
}

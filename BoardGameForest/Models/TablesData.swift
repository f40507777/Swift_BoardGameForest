//
//  TablesData.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/18.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class TablesData: NSObject {

    lazy var floorTablesArray: [Floor] = {
        
        var floorTablesDynomicArray: [Floor] = []
        
        if let path = Bundle.main.path(forResource: "FloorTables", ofType: "plist") {
            for floorDictionary in NSArray(contentsOfFile: path) as! Array<[String:Any]> {
                let floor = Floor()
                floor.name = floorDictionary["name"] as? String
                floor.floorEnum = FloorEnum(rawValue: floorDictionary["floorEnum"] as! Int)!
                floor.tableList = self.getTableArray(floorArray: floorDictionary["tableList"] as! Array<[String:Any]>)
                floorTablesDynomicArray.append(floor)
            }
        }
        
        return floorTablesDynomicArray
    }()
    
    func getTableArray(floorArray: Array<[String:Any]>) -> [Table]{
        var tableDynomicArray: [Table] = []
        for tableDictionary in floorArray {
            let table = Table()
            table.tableNumber = TableNumber(rawValue: (tableDictionary["tableNumber"] as? String)!)
            table.maximumCustoms = tableDictionary["maximumCustoms"] as? Int
            table.floor = tableDictionary["floor"] as? Int
            tableDynomicArray.append(table)
        }
        
        return tableDynomicArray
    }
    

}

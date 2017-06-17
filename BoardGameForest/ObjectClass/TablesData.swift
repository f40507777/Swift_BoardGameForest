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
                floor.floorEnum = FloorEnum(rawValue: floorDictionary["floorEnum"] as! Int)
                floor.flowLayout = self.getFloorCollectionViewLayout(floorEnum: floor.floorEnum!)
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
    
    func getFloorCollectionViewLayout(floorEnum: FloorEnum) -> UICollectionViewFlowLayout {
        let floorlayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        floorlayout.minimumInteritemSpacing = 0
        floorlayout.minimumLineSpacing = 20
        
        switch floorEnum {
            
        case .FirstFloor:
            floorlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: width / 2 - 10)
            floorlayout.itemSize = CGSize(width: width / 2 + 10, height: 64)

            break
            
        case .SecondFloor:
            floorlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            floorlayout.itemSize = CGSize(width: width / 2 - 10, height: 64)

            break
            
        case .ThirdFloor:
            floorlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            floorlayout.itemSize = CGSize(width: width / 2 - 10, height: 64)
            
            break
            

        }
        
        return floorlayout
    }
}

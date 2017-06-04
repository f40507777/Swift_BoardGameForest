//
//  ItemManager.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
    
    static private var _itemsArray: NSArray = []
    
    static private func getItemsFromPlist() -> NSArray {
        
        var itemsArray: NSArray?
        if let path = Bundle.main.path(forResource: "Items", ofType: "plist") {
            itemsArray = convertPlistArray(plistArray: NSArray(contentsOfFile: path)!)
        }
        
        
        return itemsArray!
    }
    
    static private func convertPlistArray(plistArray: NSArray) -> NSArray {
        let dynomicArray = NSMutableArray()
        for itemDic in plistArray as! [[String: AnyObject]] {
            let item = Item()
            item.name = itemDic["name"] as! String?
            item.price = itemDic["price"] as! NSNumber? as NSInteger?
            item.type = itemDic["type"] as! NSNumber? as NSInteger?
            dynomicArray.add(item)
        }
        
        return dynomicArray
    }
    
    static func getItems() -> NSArray {

        if _itemsArray.count == 0 {
            _itemsArray = getItemsFromPlist()
        }
        
        return _itemsArray
    }
}

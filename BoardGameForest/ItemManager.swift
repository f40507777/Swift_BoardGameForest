//
//  ItemManager.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/4.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
    
    static private var _itemsArray: [[Item]] = []
    
    static private var _typeNameArray: NSArray = []

    static func getItems() -> NSArray {
        
        if _itemsArray.count == 0 {
            _itemsArray = getItemsFromPlist() as! [[Item]]
        }
        
        return _itemsArray as NSArray
    }
    
    static func getTypeNameArray() -> NSArray {
        
        if _typeNameArray.count == 0 {
            _typeNameArray = getTypeNameFromPlist() 
        }
        
        return _typeNameArray as NSArray
    }
    
    
    static func getItemsFromPlist() -> NSArray {
        var itemsArray: NSArray?
        if let path = Bundle.main.path(forResource: "Items", ofType: "plist") {
            itemsArray = convertItemPlist(plistDictionary: NSDictionary(contentsOfFile: path)!)
        }
        
        
        return itemsArray!
    }
    
    static func getTypeNameFromPlist() -> NSArray {
        var typeNameArray: NSArray?
        if let path = Bundle.main.path(forResource: "Items", ofType: "plist") {
            typeNameArray = NSDictionary(contentsOfFile: path)?.allKeys as NSArray?
        }
        
        
        return typeNameArray!
    }
    
    static func convertItemPlist(plistDictionary: NSDictionary) -> NSArray {
        let dynomicTypeArray = NSMutableArray()
        for typeArray in plistDictionary.allValues {
            let dynomicItemArray = NSMutableArray()
            for itemDic in typeArray as! [[String: AnyObject]] {
                let item = Item()
                item.name = itemDic["name"] as! String?
                item.price = itemDic["price"] as! NSNumber? as NSInteger?
                item.type = itemDic["type"] as! NSNumber? as NSInteger?
                dynomicItemArray.add(item)
            }
            dynomicTypeArray.add(dynomicItemArray)
        }

        return dynomicTypeArray
    }
}

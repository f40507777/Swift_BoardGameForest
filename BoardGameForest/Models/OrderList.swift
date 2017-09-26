//
//  tempOrderList.swift
//  BoardGameForest
//
//  Created by Finn on 2017/8/30.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit
import ObjectMapper
import FirebaseDatabase

class OrderList: Mappable {
    
    var orderDictionary: [String : Order] = [:]

    lazy var list: [Order] = {
        return Array(self.orderDictionary.values)
    }()
    
    init() {
        
    }
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        orderDictionary <- map[DTORDERLIST]
    }
}

//
//  tempMealStatus.swift
//  BoardGameForest
//
//  Created by Finn on 2017/8/30.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit
import ObjectMapper

enum MealType: Int {
    case Beverage
    case Dessert
    case MainCourse
}

class MealStatus: Mappable {
    
    var name: String?
    var isSendOut: Bool?
    var price: Int = 0
    var type: Int?
    var itemID: String?
    
    init() {

    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name        <- map[DTMEALNAME]
        isSendOut   <- map[DTMEALISSENDOUT]
        price       <- map[DTMEALPRICE]
        type        <- map[DTMEALTYPE]
        itemID      <- map[DTMEALITEMID]
    }
    

}

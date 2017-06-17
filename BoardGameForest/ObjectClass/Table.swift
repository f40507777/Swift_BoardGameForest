//
//  Table.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/18.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

enum TableNumber: String {
    case A1 = "A1"
    case A2 = "A2"
    case A3 = "A3"
    case B1 = "B1"
    case B2 = "B2"
    case B3 = "B3"
    case B4 = "B4"
    case B5 = "B5"
    case C1 = "C1"
    case C2 = "C2"
}

class Table: NSObject {
    
    var tableNumber: TableNumber?
    
    var maximumCustoms: Int?
    
    var floor: Int?

}

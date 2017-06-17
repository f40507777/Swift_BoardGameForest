//
//  Floor.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/18.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

enum FloorEnum: Int {
    case FirstFloor = 0
    case SecondFloor = 1
    case ThirdFloor = 2
}

class Floor: NSObject {

    var floorEnum: FloorEnum?
    
    var tableList: Array<Table>?
    
    var flowLayout: UICollectionViewFlowLayout?
    
}

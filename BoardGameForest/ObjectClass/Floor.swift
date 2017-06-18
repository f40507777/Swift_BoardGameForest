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
    
    var floorEnum: FloorEnum? {
        didSet {
            setCollectionViewLayout(floorEnum: floorEnum!)
        }
    }
    
    var name: String?

    var tableList: Array<Table>?
    
    var flowLayout = UICollectionViewFlowLayout()
    
    func setCollectionViewLayout(floorEnum: FloorEnum) {
        let width = UIScreen.main.bounds.width
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 20
        
        switch floorEnum {
            
        case .FirstFloor:
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: width / 2 - 10)
            flowLayout.itemSize = CGSize(width: width / 2 + 10, height: 64)
            
            break
            
        case .SecondFloor:
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.itemSize = CGSize(width: width / 2 - 10, height: 64)
            
            break
            
        case .ThirdFloor:
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.itemSize = CGSize(width: width / 2 - 10, height: 64)
            
            break
            
            
        }
    }
}

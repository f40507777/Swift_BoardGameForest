//
//  FIRDataObject.swift
//  BoardGameForest
//
//  Created by Finn on 2017/8/29.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit
import Firebase

class FIRDataObject: NSObject {

    let snapshot: DataSnapshot
    var key: String { return snapshot.key }
    var ref: DatabaseReference { return snapshot.ref }

    override init() {
        self.snapshot = DataSnapshot()
    }
    
    init(snapshot: DataSnapshot) {
        
        self.snapshot = snapshot
        
        super.init()
        
        for child in snapshot.children.allObjects as? [DataSnapshot] ?? [] {
            if responds(to: Selector(child.key)) {
                setValue(child.value, forKey: child.key)
            }
        }
    }
}

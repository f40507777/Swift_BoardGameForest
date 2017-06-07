//
//  BGFTabBar.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/6.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class TabBar: UITabBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 38
        
        return sizeThatFits
    }

}

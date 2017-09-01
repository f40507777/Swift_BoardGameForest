//
//  OrderMenuTableViewCell.swift
//  BoardGameForest
//
//  Created by Finn on 2017/9/1.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

protocol OrderMenuCellDelegate: class {
    
    func additionCountEvent(mealName: String)
    
    func subtractionCountEvent(mealName: String)
}

class OrderMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countLabel: UILabel!
    
    weak var delegate: OrderMenuCellDelegate?

    private var _count: Int = 0
    
    var count:Int {
        get {
            return _count
        }
        set {
            _count = newValue < 0 ? 0 : newValue
            countLabel.text = String(_count)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    @IBAction func clickAdditionButton(_ sender: UIButton) {
        count += 1
        
    }
    
    @IBAction func clickSubtractionButton(_ sender: UIButton) {
        count -= 1
    }
    
    

}

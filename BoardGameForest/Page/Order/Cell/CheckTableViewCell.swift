//
//  CheckTableViewCell.swift
//  BoardGameForest
//
//  Created by Finn on 2018/1/4.
//  Copyright © 2018年 Finn. All rights reserved.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

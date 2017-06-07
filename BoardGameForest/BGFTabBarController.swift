//
//  BGFTabBarController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/6.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

class BGFTabBarController: UITabBarController {

    lazy var databaseAPI = DatabaseAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        databaseAPI.hackLogin()
    }
}

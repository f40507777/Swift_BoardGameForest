//
//  OrderTableNumberController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/12.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class OrderTableNumberController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "OrderTableNumberCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OrderTableNumberCollectionViewCell
        
        cell.tableNumberLabel.text = "hello"
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 64, height: 64)
    }
    


}

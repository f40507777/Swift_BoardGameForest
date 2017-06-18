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
    
    private var tablesData = TablesData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return tablesData.floorTablesArray.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (tablesData.floorTablesArray[section].tableList?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OrderTableNumberCollectionViewCell
        
        cell.tableNumberLabel.text = "hello"
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return (tablesData.floorTablesArray[indexPath.section].flowLayout.itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return (tablesData.floorTablesArray[section].flowLayout.sectionInset)
    }
    


}

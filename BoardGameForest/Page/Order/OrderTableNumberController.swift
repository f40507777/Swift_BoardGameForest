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
    
    private let reuseHeaderViewIdentifier = "OrderTableNumbeSectionView"

    private var tablesData = TablesData()
    
    private var currentIndexPath: IndexPath?
    
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
        
        cell.tableNumberLabel.text = tablesData.floorTablesArray[indexPath.section].tableList?[indexPath.row].tableNumber?.rawValue
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderViewIdentifier, for: indexPath) as! OrderTableNumbeSectionView
        
        headerView.titleLabel.text = tablesData.floorTablesArray[indexPath.section].name
        headerView.backgroundColor = UIColor.gray
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuViewController = OrderMenuViewController(table: (tablesData.floorTablesArray[indexPath.section].tableList?[indexPath.row])!)
        navigationController?.pushViewController(menuViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return (tablesData.floorTablesArray[indexPath.section].flowLayout.itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return (tablesData.floorTablesArray[section].flowLayout.sectionInset)
    }
}

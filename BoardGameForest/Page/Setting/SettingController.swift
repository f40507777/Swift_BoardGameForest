//
//  SettingController.swift
//  BoardGameForest
//
//  Created by Finn on 2017/6/10.
//  Copyright © 2017年 Finn. All rights reserved.
//

import UIKit

class SettingController: UITableViewController {

    lazy var databaseAPI = DatabaseAPI()
    
    lazy var tableData: SettingTableData = {
        return SettingTableData(viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = SettingTableData(viewController: self)
        navigationItem.title = "Setting"
    }
    
    // MARK: TableView Delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (tableData.sectionDataArray.count)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableData.sectionDataArray[section].cellArray.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        cell.textLabel?.text = tableData.sectionDataArray[indexPath.section].cellArray[indexPath.row].title
        
        return cell
    }
    
    func tableView( tableView : UITableView,  titleForHeaderInSection section: Int) -> String {
        return tableData.sectionDataArray[section].title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableData.sectionDataArray[indexPath.section].cellArray[indexPath.row].clickAciotn!()
    }
    

}

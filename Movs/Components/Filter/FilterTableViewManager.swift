//
//  FilterTableViewManager.swift
//  Movs
//
//  Created by gustavo.cosenza on 09/09/20.
//  Copyright © 2020 gustavo.cosenza. All rights reserved.
//

import UIKit

class FilterTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var description: String = ""
   
        if indexPath.row == 0 {
            description = "Date"
        } else {
            description = "Genres"
        }
        
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel!.text = description
        cell.detailTextLabel!.text = "teste"
        cell.detailTextLabel?.textColor = UIColor(named: "colorYellow")
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

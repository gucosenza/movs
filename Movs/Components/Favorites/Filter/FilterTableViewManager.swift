
import UIKit

class FilterTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var optionFilter: OptionFilterProtocol!
    private let filterManager = FilterManager.shared
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
   
        if indexPath.row == 0 {
            cell.textLabel!.text = "Date"
            cell.detailTextLabel!.text = filterManager.dateOption
        } else {
            cell.textLabel!.text = "Genres"
            cell.detailTextLabel!.text = filterManager.genreOption
        }
        
        cell.detailTextLabel?.textColor = UIColor(named: "colorYellow")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            optionFilter.optionsFilterSelected(optionFilter: .date)
        } else {
            optionFilter.optionsFilterSelected(optionFilter: .genres)
        }
    }
    
}

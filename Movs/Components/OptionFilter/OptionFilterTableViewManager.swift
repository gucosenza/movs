
import UIKit

class OptionFilterTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var selectOptionProtocol: OptionFilterTableViewManagerDelegate!
    var typeFilter: FilterTypes!
    private var favoritesManager = FavoriteManager.shared
    private let genreManager = GenreManager.shared
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch typeFilter {
        case .date:
            return favoritesManager.yearFavorites.count
        case .genres:
            return genreManager.arrayGenres.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch typeFilter {
        case .date:
            cell.textLabel?.text = favoritesManager.yearFavorites[indexPath.row]
        case .genres:
            cell.textLabel?.text = genreManager.arrayGenres[indexPath.row]
        case .none:
            print("nada")
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectOptionProtocol.selectOption(value: cell.textLabel!.text!, filterType: typeFilter)
        }
    }
    
    
}



import UIKit

class FavoriteTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var favoritesManager = FavoriteManager.shared
    var isFiltering: Bool = false
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if isFiltering {
            count = favoritesManager.filteredFavorites.count
        } else {
            count = favoritesManager.favorites.count
        }
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
        
        if isFiltering {
            cell.prepare(with: favoritesManager.filteredFavorites[indexPath.row])
        } else {
            cell.prepare(with: favoritesManager.favorites[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if isFiltering {
                print("deletar")
            } else {
                favoritesManager.deleteFavorite(index: indexPath.row)
                favoritesManager.getFavorites()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
}


import UIKit

class FavoritesTableDataSource: NSObject, UITableViewDataSource {
    
    var noResultsLabel = UILabel()
    let favorites: [FavoritesCD]
    static let identifier = "identifier"
    private let favoriteManager = FavoriteManager()
    
    init(favorites: [FavoritesCD]) {
        self.favorites = favorites
        super.init()
        
        noResultsLabel.text = "Você não possui favoritos"
        noResultsLabel.textAlignment = .center
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = favorites.count
        tableView.backgroundView = count == 0 ? noResultsLabel : nil
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableDataSource.identifier, for: indexPath) as! FavoriteTableViewCell
        cell.prepare(with: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteManager.deleteFavorite(favorite: favorites[indexPath.row])
            tableView.reloadData()
        }
    }
    
    
}

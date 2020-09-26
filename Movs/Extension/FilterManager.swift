
import Foundation

class FilterManager {
    
    static let shared = FilterManager()
    var dateOption: String = ""
    var genreOption: String = ""
    
    func filter(favorites: [FavoritesCD]) -> [FavoritesCD] {
        var filtered = favorites
        if !dateOption.isEmpty {
            filtered = filtered.filter({(favorite: FavoritesCD) -> Bool in
                return favorite.year!.contains(dateOption)
            })
        }
        
        if !genreOption.isEmpty {
            filtered = filtered.filter({(favorite: FavoritesCD) -> Bool in
                return favorite.genre!.contains(genreOption)
            })
        }
        return filtered
    }
}

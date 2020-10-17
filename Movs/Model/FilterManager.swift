
import Foundation

struct FilterOption {
    var date: String
    var genre: String
}

class FilterManager {
    
    static let shared = FilterManager()
    private var filterOption = FilterOption(date: "", genre: "")
    
    func filter(favorites: [FavoritesCD]) -> [FavoritesCD] {
        var filtered = favorites
        if !filterOption.date.isEmpty {
            filtered = filtered.filter({(favorite: FavoritesCD) -> Bool in
                return favorite.year!.contains(filterOption.date)
            })
        }
        
        if !filterOption.genre.isEmpty {
            filtered = filtered.filter({(favorite: FavoritesCD) -> Bool in
                return favorite.genre!.contains(filterOption.genre)
            })
        }
        return filtered
    }
    
    func setDateOption(date: String) {
        self.filterOption.date = date
    }
    
    func getDateOption() -> String {
        return self.filterOption.date
    }
    
    func setGenreOption(genre: String) {
        self.filterOption.genre = genre
    }
    
    func getGenreOption() -> String {
        return self.filterOption.genre
    }
}


import Foundation

class FavoriteManager {
    
    static let shared = FavoriteManager()
    private var coreDataManager = CoreDataManager()
    var favorites: [FavoritesCD] = []
    var filteredFavorites: [FavoritesCD] = []
    
    func getFavorites() {
        favorites = coreDataManager.getFavorites()
    }

    func isFavorite(idMovie: Int) -> Bool{
        getFavorites()

        for movie in favorites {
            if movie.movieId == idMovie {
                return true
            }
        }
        return false
    }

    func saveFavorite(movie: Movie) {
        coreDataManager.saveFavorite(movie: movie)
    }

    func deleteFavorite(index: Int) {
        coreDataManager.deleteFavorite(index: index)
    }
    
    func filterFavorite(date: String) {
        filteredFavorites = favorites.filter({(favorite: FavoritesCD) -> Bool in
            return favorite.year!.contains(date)
        })
    }
    
}


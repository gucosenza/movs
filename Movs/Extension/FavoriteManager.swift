
import Foundation

class FavoriteManager {
    
    static let shared = FavoriteManager()
    private var coreDataManager = CoreDataManager()
    private let filterManager = FilterManager.shared
    var favorites: [FavoritesCD] = []
    var filteredFavorites: [FavoritesCD] = []
    var yearFavorites: [String] = []
    
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
    
    func filterFavorite() {
        filteredFavorites = filterManager.filter(favorites: favorites)
    }
    
    func getYearFavorites() {
        yearFavorites.removeAll()
        for favorite in favorites {
            if !yearFavorites.contains(favorite.year!) {
                yearFavorites.append(favorite.year!)
            }
        }
    }
    
}


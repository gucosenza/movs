
import Foundation

class FavoriteManager {

    private var coreDataManager = CoreDataManager()
    
    func getFavorites() -> [FavoritesCD] {
        coreDataManager.getFavorites()
        return coreDataManager.favorites
    }

    func isFavorite(idMovie: Int) -> Bool{
        coreDataManager.getFavorites()

        for movie in coreDataManager.favorites {
            if movie.movieId == idMovie {
                return true
            }
        }
        return false
    }

    func saveFavorite(movie: Movie) {
        coreDataManager.saveFavorite(movie: movie)
    }

    func deleteFavorite(movie: Movie) {
        let favorite = FavoritesCD()
        favorite.movieId = Int32(movie.id)
        favorite.image = movie.posterPath
        favorite.name = movie.title
        favorite.overview = movie.overview
        favorite.year = String(movie.releaseDate.dropLast(6))
        coreDataManager.deleteFavorite(favorite: favorite)
    }

    func deleteFavorite(favorite: FavoritesCD) {
        coreDataManager.deleteFavorite(favorite: favorite)
    }
    
    func deleteFavorite(index: Int) {
        coreDataManager.deleteFavorite(index: index)
    }
    
    

}


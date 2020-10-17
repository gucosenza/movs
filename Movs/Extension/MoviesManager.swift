import UIKit

class MoviesManager {
    
    static let shared = MoviesManager()
//    private var movies = [[Movie]]()
    private var movies = [Movie]()
    
//    private var page: Int = 5
//    private let networkManager = NetworkManager()
//
//    func getMovie() {
//        networkManager.loadMovies(onComplete: { (moviesRest) in
//            for movie in moviesRest.results {
//                self.movies.append(movie)
//            }
//
//            self.page = self.page + 1
//        }, onError: { (error) in
//            print("Ocorreu um erro ao carregar os filmes")
//        }, page: page)
//    }
    
    func addArrayMovies(movies: Movie) {
        self.movies.append(movies)
    }
    
    func allMovies() -> [Movie] {
        return movies
    }
    
}



import Foundation

class MoviesManager {
    
    private var page: Int = 1
    var movies = [Movie]()
    private let networkManager = NetworkManager()
    
    func getMovie() {
        networkManager.loadMovies(onComplete: { (moviesRest) in
            for movie in moviesRest.results {
                self.movies.append(movie)
            }
            
            self.page = self.page + 1
        }, onError: { (error) in
            print("Ocorreu um erro ao carregar os filmes")
        }, page: page)
    }
    
}



import Foundation

class MoviesManager {
    
    private var page: Int = 1
    var movies: MovieModel!
    
    func getMovie() {
        let fileURL = Bundle.main.url(forResource: "movie", withExtension: "json")!
        let jsonData = try! Data(contentsOf: fileURL)
        let jsonDecoder = JSONDecoder()
        movies = try! jsonDecoder.decode(MovieModel.self, from: jsonData)
        
        //Network.getmovie(page: page)
        page += 1
    }
    
}

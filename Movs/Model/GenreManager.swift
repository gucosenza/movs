
import Foundation

class GenreManager {
    
    private var genres: Genre!
    private let network = Network()
    
    var dictionaryGenres = [28:"Action", 12:"Adventure", 16:"Animation", 35:"Comedy", 80:"Crime", 99:"Documentary", 18:"Drama", 10751:"Family", 14:"Fantasy", 36:"History", 27:"Horror", 10402:"Music", 9648:"Mystery", 10749:"Romance", 878:"Science Fiction", 10770:"TV Movie", 53:"Thriller", 10752:"War", 37:"Western"]
    
    func getGenreApi() {
        
        network.loadGenre(onComplete: { (genres) in
            self.dictionaryGenres = genres
        }) { (error) in
            switch error {
            case .invalidJson:
                print("JSON Inválido")
            case .url:
                print("url")
            case .taskError(let error):
                print(error)
            case .noResponse:
                print("Response")
            case .noData:
                print("sem dados")
            case .responseStatusCode(let code):
                print(code)
            }
        }
        
//        for genre in genresApi.genres {
//            self.dictionaryGenres[genre.id] = genre.name
//        }
    }
    
    
    func getGenres(ids: [Int]) -> String {
        var genresMovie = ""
        for id in ids {
            genresMovie = genresMovie + dictionaryGenres[id]! + ", "
        }
        return String(genresMovie.dropLast(2))
    }
}

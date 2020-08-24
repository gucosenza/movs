
import Foundation

class NetworkManager {
    
    private let network = Network()
    var dictionaryGenres = [Int: String]()

    func loadMovies(onComplete: @escaping (MovieModel) -> Void, onError: @escaping (NetworkError) -> Void, page: Int) {
        
        let urlMovies = Config.basePath + "/movie/popular?page=" + String(page) + "&language=en-US&api_key=" + Config.apiKey
        guard let url = URL(string: urlMovies ) else {
            onError(.url)
            return
        }
        print("url: " + urlMovies)
        
        network.rest(url: url) { (data, error) in
            guard let data = data else {return}
               do{
                   let moviesApi = try JSONDecoder().decode(MovieModel.self, from: data)
                   onComplete(moviesApi)
                   print("Requisiçao movies feita!!")
               }catch {
                   print(error)
                    onError(.invalidJson)
               }
        }
    }
    
    
    func loadGenre(onComplete: @escaping (Dictionary<Int, String>) -> Void, onError: @escaping (NetworkError) -> Void) {
        
        let urlGenres = Config.basePath + "/genre/movie/list?language=en-US&api_key=" + Config.apiKey
        guard let url = URL(string: urlGenres ) else {
            onError(.url)
            return
        }
        
        network.rest(url: url) { (data, error) in
            guard let data = data else {return}
               do{
                    let genresApi = try JSONDecoder().decode(GenresModel.self, from: data)
                
                   for genre in genresApi.genres {
                       self.dictionaryGenres[genre.id] = genre.name
                   }
                   
                   onComplete(self.dictionaryGenres)
                print("Requisiçao genre feita!!")
               }catch {
                   print(error)
                    onError(.invalidJson)
               }
        }
    }

}

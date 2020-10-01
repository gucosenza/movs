
import Foundation

class NetworkManager {
    
    private let network = Network()
    private var dictionaryGenres = [Int: String]()
    private var arrayGenres: [String] = []

    func loadMovies(onComplete: @escaping (MovieModel) -> Void, onError: @escaping (NetworkError) -> Void, page: Int) {
        
        let url = Endpoints.urlMovies(page).url
        print("url: \(url)")
        
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
        
        let url = Endpoints.urlGenres.url
        print("urlGenres: \(url)")
        
        network.rest(url: url) { (data, error) in
            guard let data = data else {return}
               do{
                let genresApi = try JSONDecoder().decode(GenresModel.self, from: data)
                for genre in genresApi.genres {
                    self.dictionaryGenres[genre.id] = genre.name
                }
        
                onComplete(self.dictionaryGenres)
                print("Requisiçao genre feita!!")
               } catch {
                   print(error)
                onError(.invalidJson)
               }
        }
    }

}

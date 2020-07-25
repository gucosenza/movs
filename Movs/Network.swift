
enum RestError {
    case url
    case taskError (error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}

import Foundation

class Network {
    
    var dictionaryGenres = [Int: String]()
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["content-type":"application/json;charset=utf-8"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private let session = URLSession(configuration: configuration)
    
    func loadGenre(onComplete: @escaping (Dictionary<Int, String>) -> Void, onError: @escaping (RestError) -> Void) {
        
        let urlGenres = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=e4aa100e47a2d27f927f4797a4bf5607"
        guard let url = URL(string: urlGenres ) else {
            onError(.url)
            return
        }
        
        //monta a requisicao
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            // se nao tiver erro no aplicativo para fazer requisicao
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                // se o status da requisicao deu certo (200)
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do{
                        let genresApi = try JSONDecoder().decode(GenresModel.self, from: data)
                        
                        for genre in genresApi.genres {
                            self.dictionaryGenres[genre.id] = genre.name
                        }
                        
                        onComplete(self.dictionaryGenres)
                        
                    }catch {
                        onError(.invalidJson)
                    }
                }else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            }else {
                onError(.taskError(error: error!))
            }
        }
        //executa a requisicao
        dataTask.resume()
    }
}


import Foundation

enum Endpoints {
    private var baseURL: String { return Config.basePath }

    case urlGenres
    case urlMovies(Int)

    private var fullPath: String {
        var endpoint:String
        switch self {
        case .urlGenres:
            endpoint = "/genre/movie/list?language=en-US&api_key=\(Config.apiKey)"
        case .urlMovies(let page):
            endpoint = "/movie/popular?page=\(page)&language=en-US&api_key=\(Config.apiKey)"
        }
        return baseURL + endpoint
    }

    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(Endpoints.self) is not valid")
        }
        return url
    }
}

enum ImageEndpoints {
    private var baseURL: String { return Config.imagePath }
    
    case posterPath(String)
    case backdropPath(String)
    
    private var fullPath: String {
        var endpoint:String
        switch self {
        case .posterPath(let name):
            endpoint = "/w185\(name)"
        case .backdropPath(let name):
            endpoint = "/w300\(name)"
        }
        return baseURL + endpoint
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(ImageEndpoints.self) is not valid")
        }
        return url
    }
}

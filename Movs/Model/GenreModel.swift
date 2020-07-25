
import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenresModel: Decodable {
    let genres: [Genre]
}

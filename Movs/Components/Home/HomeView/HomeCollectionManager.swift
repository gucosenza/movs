
import UIKit

protocol ButtonActionProtocol: AnyObject {
    func navigationDetail(movie: Movie)
    func reloadFilter()
    func getMoreMovies()
}

class HomeCollectionManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var isFiltering: Bool = false
    private let favoriteManager = FavoriteManager()
    var movies = [Movie]()
    var filteredMovies: [Movie] = []
    var buttonActionProtocol: ButtonActionProtocol!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovies.count
        }else{
            return movies.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        if isFiltering {
            cell.configure(movie: filteredMovies[indexPath.row],favorite: favoriteManager.isFavorite(idMovie: filteredMovies[indexPath.row].id))
        } else {
            cell.configure(movie: movies[indexPath.row],favorite: favoriteManager.isFavorite(idMovie: movies[indexPath.row].id))
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = collectionView.indexPathsForSelectedItems?.first {
            if isFiltering {
                buttonActionProtocol.navigationDetail(movie: filteredMovies[index.row])
            } else {
                buttonActionProtocol.navigationDetail(movie: movies[index.row])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == movies.count - 10 {
//            print("carrega mais")
//            buttonActionProtocol.getMoreMovies()
//        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = movies.filter({( movie : Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        buttonActionProtocol.reloadFilter()
    }
}

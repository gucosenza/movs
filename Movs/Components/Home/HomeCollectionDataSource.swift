import UIKit

class HomeCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    static let identifier = "identifier"
    let movies: [Movie]
    let favoriteManager = FavoriteManager()
    
    private lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Não existe filme para ser exibido"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    init(movies: [Movie]) {
        self.movies = movies
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.backgroundView = movies.count == 0 ? noResultsLabel : nil
        print(movies.count)
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionDataSource.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.configure(movie: movies[indexPath.row],favorite: favoriteManager.isFavorite(idMovie: movies[indexPath.row].id))
        
        return cell
    }
}

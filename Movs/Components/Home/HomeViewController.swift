
import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    var movies = [Movie]()
    let favoriteManager = FavoriteManager()
    let genreManager = GenreManager()
    let spinner = SpinnerView()
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let border = (( UIScreen.main.bounds.width - (185*2)) / 3)
        layout.sectionInset = UIEdgeInsets(top: 10, left: border, bottom: 0, right: border)
        layout.itemSize = CGSize(width: 185, height: 308)
        layout.minimumInteritemSpacing = ((UIScreen.main.bounds.width - (185*2)) / 3)
        layout.minimumLineSpacing = ((UIScreen.main.bounds.width - (185*2)) / 3)
        var co = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        co.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        co.backgroundColor = .white
        co.translatesAutoresizingMaskIntoConstraints = false
        return co
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "colorYellow")
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        genreManager.getGenreApi()
        
        self.view = spinner.startSpinner(self.view.bounds)
        networkManager.loadMovies(onComplete: { (moviesRest) in
            for movie in moviesRest.results {
                self.movies.append(movie)
            }
            DispatchQueue.main.async {
                self.spinner.removeSpinner(spinner: self.view)
                self.view = self.collectionView
                self.collectionView.reloadData()
            }
        }, onError: { (error) in
            print("Ocorreu um erro ao carregar os filmes")
        }, page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}

extension HomeViewController: UICollectionViewDataSource {
    
        func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
            }
    
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return movies.count
            }
        
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
                cell.configure(movie: movies[indexPath.row],favorite: favoriteManager.isFavorite(idMovie: movies[indexPath.row].id))
    
                return cell
            }
}

extension HomeViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let index = collectionView.indexPathsForSelectedItems?.first {
                navigationController!.pushViewController(DetailViewController(movie: movies[index.row]), animated: true)
            }
        }
}

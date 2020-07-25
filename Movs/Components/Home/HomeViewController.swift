
import UIKit

protocol DetailProtocol {
    func navigationDetailViewController(movie: Movie)
}

private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController, DetailProtocol {
    
    let moviesManager = MoviesManager()
    
    let homeCollectionView = HomeCollectionView()
    var movies: [Movie]?
    var homeCollectionDataSource: HomeCollectionDataSource!
    var homeCollectionDelegateFlowLayout: HomeCollectionDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
        
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "colorYellow")
        
        moviesManager.getMovie()
        
        homeCollectionView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionDataSource.identifier)
        homeCollectionDelegateFlowLayout = HomeCollectionDelegate(view: self.view, movies: moviesManager.movies.results)
        homeCollectionView.collectionView.delegate = homeCollectionDelegateFlowLayout
        homeCollectionDataSource = HomeCollectionDataSource(movies: moviesManager.movies.results)
        homeCollectionView.collectionView.dataSource = homeCollectionDataSource
        homeCollectionDelegateFlowLayout.detailProtocol = self
//        self.homeCollectionView.collectionView.reloadData()
            
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        DispatchQueue.main.async {
//            self.homeCollectionView.collectionView.reloadData()
//        }
//    }

    override func loadView() {
        self.view = homeCollectionView
    }

    func navigationDetailViewController(movie: Movie) {
        let detailController = DetailViewController(movie: movie)
        navigationController!.pushViewController(detailController, animated: true)
    }
}




import UIKit

class HomeViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    var genreManager = GenreManager.shared
    let homeCollectionManager = HomeCollectionManager()
    let searchController = UISearchController(searchResultsController: nil)
    let homeView = HomeView()
    
    override func loadView() {
        super.loadView()
        self.view = homeView
        
        self.title = "Movies"
               
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "colorYellow")

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.barTintColor = .black
        UISearchBar.appearance().tintColor = UIColor.black
        navigationItem.hidesSearchBarWhenScrolling = false
       
        homeCollectionManager.buttonActionProtocol = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.collectionView.dataSource = homeCollectionManager
        homeView.collectionView.delegate = homeCollectionManager
        homeView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        homeView.startSpinner()
        
        genreManager.getGenreApi()
        
        networkManager.loadMovies(onComplete: { (moviesRest) in
            for movie in moviesRest.results {
                self.homeCollectionManager.movies.append(movie)
            }
            DispatchQueue.main.async {
                self.homeView.removeSpinner()
                self.homeView.collectionView.reloadData()
            }
        }, onError: { (error) in
            print("Ocorreu um erro ao carregar os filmes")
        }, page: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.homeView.collectionView.reloadData()
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension HomeViewController: ButtonActionProtocol {
    func navigationDetail(movie: Movie) {
        navigationController!.pushViewController(DetailViewController(movie: movie), animated: true)
    }
    
    func reloadFilter() {
        self.homeView.collectionView.reloadData()
    }
}

extension HomeViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    self.homeCollectionManager.isFiltering = self.isFiltering()
    self.homeCollectionManager.filterContentForSearchText(searchController.searchBar.text!)
  }
}


import UIKit

class HomeViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    var genreManager = GenreManager.shared
    let homeCollectionManager = HomeCollectionManager()
    let searchController = UISearchController(searchResultsController: nil)
    private let homeView = HomeView()
    private var isFetchInProgress: Bool = false
    private var page: Int = 1
    private var total = 0
    
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
        
        getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.homeView.collectionView.reloadData()
        }
    }
    
    func getMovies () {
        guard !isFetchInProgress else {
          return
        }
        
        isFetchInProgress = true
        networkManager.loadMovies(onComplete: { (moviesRest) in
            
            
            for movie in moviesRest.results {
                self.homeCollectionManager.movies.append(movie)
            }
            DispatchQueue.main.async {
                self.page += 1
                self.isFetchInProgress = false
                self.total = moviesRest.totalResults
                self.homeView.removeSpinner()
                self.homeView.collectionView.reloadData()
            }
 
        }, onError: { (error) in
            self.isFetchInProgress = false
            print("Ocorreu um erro ao carregar os filmes")
        }, page: self.page)
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
      let startIndex = homeCollectionManager.movies.count - newMovies.count
      let endIndex = startIndex + newMovies.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension HomeViewController: ButtonActionProtocol {
    func getMoreMovies() {
        if !isFetchInProgress && self.homeCollectionManager.movies.count <= total {
            self.getMovies()
            self.homeView.collectionView.reloadData()
        }
    }
    
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

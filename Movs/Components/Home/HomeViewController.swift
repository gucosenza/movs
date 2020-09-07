
import UIKit

class HomeViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    var genreManager = GenreManager.shared
    let spinner = SpinnerView()
    let homeCollectionManager = HomeCollectionManager()
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let border = (( UIScreen.main.bounds.width - (185*2)) / 3)
        layout.sectionInset = UIEdgeInsets(top: 10, left: border, bottom: 0, right: border)
        layout.itemSize = CGSize(width: 185, height: 308)
        layout.minimumInteritemSpacing = ((UIScreen.main.bounds.width - (185*2)) / 3)
        layout.minimumLineSpacing = ((UIScreen.main.bounds.width - (185*2)) / 3)
        var collect = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collect.backgroundColor = .white
        collect.translatesAutoresizingMaskIntoConstraints = false
        return collect
    }()
    
    override func loadView() {
        super.loadView()
        
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
        
        collectionView.dataSource = homeCollectionManager
        collectionView.delegate = homeCollectionManager
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        self.view = spinner.startSpinner(self.view.bounds)
        
        networkManager.loadGenre(onComplete: { (dictionaryGenres) in
            self.genreManager.dictionaryGenres = dictionaryGenres
        }) { (error) in
            print("Ocorreu um erro ao carregar os generos")
        }
        
        networkManager.loadMovies(onComplete: { (moviesRest) in
            for movie in moviesRest.results {
                self.homeCollectionManager.movies.append(movie)
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
        self.collectionView.reloadData()
    }
}

extension HomeViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    self.homeCollectionManager.isFiltering = self.isFiltering()
    self.homeCollectionManager.filterContentForSearchText(searchController.searchBar.text!)
  }
}

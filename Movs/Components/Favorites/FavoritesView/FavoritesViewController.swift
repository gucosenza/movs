import UIKit

private let reuseIdentifier = "Cell"

protocol FavoritesViewDelegate {
    func removeFilter()
}

protocol FavoritesViewCoordinator {
    func favoritesViewControllerSelectFilter()
}

class FavoritesViewController: UIViewController {
    
    private let favoriteManager = FavoriteManager.shared
    private let favoriteTableViewManager = FavoriteTableViewManager()
    private let filterManager = FilterManager.shared
    let favoritesView = FavoritesView()
    var coordinator: FavoritesViewCoordinator!

    override func loadView() {
        super.loadView()
        self.view = favoritesView
        
        self.title = "Favorites"
        navigationController!.navigationBar.tintColor = .black
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "colorYellow")
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(filterClicked))
        filterButton.tintColor = .black
        self.navigationItem.rightBarButtonItem  = filterButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesView.tableView.dataSource = favoriteTableViewManager
        favoritesView.tableView.delegate = favoriteTableViewManager
        favoritesView.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        favoritesView.favoritesViewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.favoriteManager.getFavorites()
            self.favoritesView.tableView.reloadData()
        }
    }
    
    @objc private func filterClicked() {
        coordinator.favoritesViewControllerSelectFilter()
    }
    
    func applyFilter() {
        self.favoriteManager.filterFavorite()
        self.favoriteTableViewManager.isFiltering = true
        self.favoritesView.removeFilterHidden(isHidden: false)
    }

}

extension FavoritesViewController: FavoritesViewDelegate {
    func removeFilter() {
        favoriteTableViewManager.isFiltering = false
        filterManager.setDateOption(date: "")
        filterManager.setGenreOption(genre: "")
        self.favoritesView.tableView.reloadData()
    }
}

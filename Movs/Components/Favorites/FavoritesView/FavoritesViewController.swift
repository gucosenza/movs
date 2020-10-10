import UIKit

private let reuseIdentifier = "Cell"

protocol ApplyFilterActionDelegate {
    func applyFilter()
}

protocol FavoritesViewDelegate {
    func removeFilter()
}

class FavoritesViewController: UIViewController {
    
    private let favoriteManager = FavoriteManager.shared
    private let favoriteTableViewManager = FavoriteTableViewManager()
    let filterViewController = FilterViewController()
    
    let favoritesView = FavoritesView()

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

        filterViewController.applyFilterActionDelegate = self
        favoritesView.favoritesViewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.favoriteManager.getFavorites()
            self.favoritesView.tableView.reloadData()
        }
    }
    
    @objc private func filterClicked() {
        navigationController!.pushViewController(filterViewController, animated: true)
    }

}

extension FavoritesViewController: FavoritesViewDelegate {
    func removeFilter() {
        favoriteTableViewManager.isFiltering = false
        self.favoritesView.tableView.reloadData()
    }
}

extension FavoritesViewController: ApplyFilterActionDelegate {
    func applyFilter() {
        self.favoriteManager.filterFavorite()
        self.favoriteTableViewManager.isFiltering = true
        self.favoritesView.removeFilterHidden(isHidden: false)
    }
}

import UIKit

class FavoritesViewController: UIViewController {
    
    private let coreDataManager = CoreDataManager()
    
    let favoritesView = FavoritesView()
    var favoritesTableDataSource: FavoritesTableDataSource?
    var favoritesTableViewDelegate: FavoritesTableViewDelegate!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        setupViews()
        
        coreDataManager.getFavorites()
        
        favoritesView.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoritesTableDataSource.identifier)
        favoritesTableDataSource = FavoritesTableDataSource(favorites: coreDataManager.favorites)
        favoritesView.tableView.dataSource = favoritesTableDataSource
        favoritesView.tableView.delegate = favoritesTableViewDelegate
//        favoritesView.tableView.separatorStyle = .none

        favoritesView.tableView.reloadData()
    }
    
    override func loadView() {
        self.view = favoritesView
    }

}

extension FavoritesViewController: CodeView {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Favorites"
        navigationController!.navigationBar.tintColor = .black
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "colorYellow")
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: nil, action: nil)
        filterButton.tintColor = .black
        self.navigationItem.rightBarButtonItem  = filterButton
    }
    
}

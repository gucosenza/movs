import UIKit

private let reuseIdentifier = "Cell"

protocol ApplyFilterActionDelegate {
    func applyFilter(date: String)
}

class FavoritesViewController: UIViewController {
    
    private let favoriteManager = FavoriteManager.shared
    private let favoriteTableViewManager = FavoriteTableViewManager()
    let filterViewController = FilterViewController()
    
    lazy var tableView: UITableView = {
            let table = UITableView()
            table.translatesAutoresizingMaskIntoConstraints = false
    //        table.separatorColor = .white
            table.separatorStyle = .none
            return table
        }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var removeFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove Filter", for: .normal)
        button.setTitleColor(UIColor(named: "colorYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 20)
        button.backgroundColor = UIColor(named: "colorDarkBlue")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(removeFilterClicked), for: .touchUpInside)
        return button
    }()

    override func loadView() {
        super.loadView()
               
        navigationController!.navigationBar.tintColor = .black
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "colorYellow")
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(filterClicked))
        filterButton.tintColor = .black
        self.navigationItem.rightBarButtonItem  = filterButton
        
        removeFilterHidden(isHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = favoriteTableViewManager
        tableView.delegate = favoriteTableViewManager
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        setupViews()
        filterViewController.applyFilterActionDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
//            self.favoriteTableViewManager.favorites = self.core.getFavorites()
            self.favoriteManager.getFavorites()
            self.tableView.reloadData()
        }
    }
    
    @objc private func filterClicked() {
        navigationController!.pushViewController(filterViewController, animated: true)
    }
    
    @objc private func removeFilterClicked() {
        favoriteTableViewManager.isFiltering = false
        removeFilterHidden(isHidden: true)
        self.tableView.reloadData()
    }
    
    func removeFilterHidden(isHidden: Bool) {
        removeFilterButton.isHidden = isHidden
    }

}

extension FavoritesViewController: CodeView {
    func buildViewHierarchy() {
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(removeFilterButton)
        stackView.addArrangedSubview(tableView)
    }
    
    func setupConstraints() {
        
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        removeFilterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        removeFilterButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive = true
        removeFilterButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        removeFilterButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true

        tableView.topAnchor.constraint(equalTo: removeFilterButton.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Favorites"
    }
}

extension FavoritesViewController: ApplyFilterActionDelegate {
    func applyFilter(date: String) {
        self.favoriteManager.filterFavorite(date: date)
        self.favoriteTableViewManager.isFiltering = true
        self.removeFilterButton.isHidden = false
    }
}

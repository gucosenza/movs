import UIKit

private let reuseIdentifier = "Cell"

class FavoritesViewController: UIViewController {
    
    lazy var tableView: UITableView = {
            let table = UITableView()
            table.translatesAutoresizingMaskIntoConstraints = false
    //        table.separatorColor = .white
            table.separatorStyle = .none
            return table
        }()
    
    lazy var stackview: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove Filter", for: .normal)
        button.setTitleColor(UIColor(named: "colorYellow"), for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 20)
        button.backgroundColor = UIColor(named: "colorDarkBlue")
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        return button
    }()

    let core = CoreDataManager()
    private let favoriteTableViewManager = FavoriteTableViewManager()

    override func loadView() {
        super.loadView()
        
        self.title = "Favorites"
               
       navigationController!.navigationBar.tintColor = .black
       navigationController!.navigationBar.isTranslucent = false
       navigationController!.navigationBar.barTintColor = UIColor(named: "colorYellow")
       let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(filterClicked))
       filterButton.tintColor = .black
       self.navigationItem.rightBarButtonItem  = filterButton
        
        view.addSubview(tableView)
               
        NSLayoutConstraint.activate([
        tableView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        tableView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        tableView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = favoriteTableViewManager
        tableView.delegate = favoriteTableViewManager
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.favoriteTableViewManager.favorites = self.core.getFavorites()
            self.tableView.reloadData()
        }
    }
    
    
    @objc private func filterClicked() {
        let filterController = FilterViewController()
        navigationController!.pushViewController(filterController, animated: true)
    }

}

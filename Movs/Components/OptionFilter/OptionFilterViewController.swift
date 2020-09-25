
import UIKit

private let reuseIdentifier = "Cell"

protocol SelectOptionProtocol {
    func selectOption (value: String, filterType: FilterTypes)
}

class OptionFilterViewController: UIViewController {
    
    var optionFilter: FilterTypes? = nil
    private let optionFilterTableViewManager = OptionFilterTableViewManager()
    private let favoriteManager = FavoriteManager.shared
    private let genreManager = GenreManager.shared
    private let filterManager = FilterManager.shared
    
    private lazy var chooseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 20)
        button.backgroundColor = UIColor(named: "colorYellow")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(applyOption), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(optionFilter: FilterTypes) {
        self.optionFilter = optionFilter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = optionFilterTableViewManager
        tableView.delegate = optionFilterTableViewManager
        optionFilterTableViewManager.selectOptionProtocol = self
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        favoriteManager.getYearFavorites()
        genreManager.getGenresFilter()
        
        switch optionFilter {
        case .date:
            self.title = "Date"
            optionFilterTableViewManager.typeFilter = .date
        case .genres:
            self.title = "Genres"
            optionFilterTableViewManager.typeFilter = .genres
        case .none:
            print("erro")
        }
        self.tableView.reloadData()
    }
    
    @objc func applyOption() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OptionFilterViewController: SelectOptionProtocol {
    func selectOption (value: String, filterType: FilterTypes) {
        switch filterType {
        case .date:
            filterManager.dateOption = value
        case .genres:
            filterManager.genreOption = value
        }
    }
}

extension OptionFilterViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(chooseButton)
    }
    
    func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: chooseButton.topAnchor, constant: -20).isActive = true
        
        chooseButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        chooseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        chooseButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
        chooseButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Filtro"
    }
    
}

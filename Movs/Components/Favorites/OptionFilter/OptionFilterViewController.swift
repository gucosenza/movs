
import UIKit

private let reuseIdentifier = "Cell"

protocol OptionFilterTableViewManagerDelegate {
    func selectOption (value: String, filterType: FilterTypes)
}

protocol OptionFilterViewDelegate {
    func applyOption()
}

protocol OptionFilterViewControllerCoordinator {
    func optionChosen()
}

class OptionFilterViewController: UIViewController {
    
    var optionFilter: FilterTypes? = nil
    private let optionFilterTableViewManager = OptionFilterTableViewManager()
    private let favoriteManager = FavoriteManager.shared
    private let genreManager = GenreManager.shared
    private let filterManager = FilterManager.shared
    var coordinator: OptionFilterViewControllerCoordinator?
    
    private var optionFilterView = OptionFilterView()
    
    init(optionFilter: FilterTypes) {
        self.optionFilter = optionFilter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = optionFilterView
        self.title = "Filtro"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionFilterView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        optionFilterView.tableView.dataSource = optionFilterTableViewManager
        optionFilterView.tableView.delegate = optionFilterTableViewManager
        
        optionFilterTableViewManager.selectOptionProtocol = self
        optionFilterView.optionFilterViewDelegate = self
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
        self.optionFilterView.tableView.reloadData()
    }
}

extension OptionFilterViewController: OptionFilterViewDelegate {
    func applyOption() {
        coordinator?.optionChosen()
    }
}

extension OptionFilterViewController: OptionFilterTableViewManagerDelegate {
    func selectOption (value: String, filterType: FilterTypes) {
        switch filterType {
        case .date:
            filterManager.setDateOption(date: value)
        case .genres:
            filterManager.setGenreOption(genre: value)
        }
    }
}

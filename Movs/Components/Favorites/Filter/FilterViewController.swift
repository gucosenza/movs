
import UIKit

protocol OptionFilterProtocol {
    func optionsFilterSelected(optionFilter: FilterTypes)
}

protocol FilterViewControllerCoordinator {
    func applyFilter()
    func listFilterOption(optionFilter: FilterTypes)
}

class FilterViewController: UIViewController {
    
    var filterViewControllerCoordinator: FilterViewControllerCoordinator!
    private let reuseIdentifier = "Cell"
    private let filterTableViewManager = FilterTableViewManager()
    let filterView = FilterView()
    
    override func loadView() {
        self.view = filterView
        self.title = "Filtro"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        filterView.tableView.dataSource = filterTableViewManager
        filterView.tableView.delegate = filterTableViewManager
        
        filterView.filterViewDelegate = self
        filterTableViewManager.optionFilter = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.filterView.tableView.reloadData()
    }
}

extension FilterViewController: FilterViewDelegate {
    func applyFilterView() {
        filterViewControllerCoordinator.applyFilter()
    }
}

extension FilterViewController: OptionFilterProtocol {
    func optionsFilterSelected(optionFilter: FilterTypes) {
        filterViewControllerCoordinator.listFilterOption(optionFilter: optionFilter)
    }
}

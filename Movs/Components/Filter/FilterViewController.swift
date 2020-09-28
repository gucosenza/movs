
import UIKit

protocol OptionFilterProtocol {
    func optionsFilterSelected(optionFilter: FilterTypes)
}

protocol FilterViewDelegate {
    func applyFilterView()
}

class FilterViewController: UIViewController {
    
    var applyFilterActionDelegate: ApplyFilterActionDelegate!
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
        applyFilterActionDelegate.applyFilter()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension FilterViewController: OptionFilterProtocol {
    func optionsFilterSelected(optionFilter: FilterTypes) {
        navigationController!.pushViewController(OptionFilterViewController(optionFilter: optionFilter), animated: true)
    }
}


import UIKit

protocol OptionFilterProtocol {
    func optionsFilterSelected(optionFilter: FilterTypes)
}

class FilterViewController: UIViewController {
    
    var applyFilterActionDelegate: ApplyFilterActionDelegate!
    private let reuseIdentifier = "Cell"
    private let filterTableViewManager = FilterTableViewManager()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 20)
        button.backgroundColor = UIColor(named: "colorYellow")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
            let table = UITableView()
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = filterTableViewManager
        tableView.delegate = filterTableViewManager
        
        filterTableViewManager.optionFilter = self

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    @objc func applyFilter() {
        applyFilterActionDelegate.applyFilter()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension FilterViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(applyButton)
    }
    
    func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -20).isActive = true
        
        applyButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        applyButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
        applyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Filtro"
    }
    
}

extension FilterViewController: OptionFilterProtocol {
    func optionsFilterSelected(optionFilter: FilterTypes) {
        navigationController!.pushViewController(OptionFilterViewController(optionFilter: optionFilter), animated: true)
    }
}

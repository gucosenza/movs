
import UIKit

class FavoritesView: UIView {
    
    var favoritesViewDelegate: FavoritesViewDelegate!

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
//        table.separatorColor = .white
        table.separatorStyle = .none
        return table
    }()
    
    lazy var stackView: UIStackView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        removeFilterHidden(isHidden: true)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func removeFilterClicked() {
        removeFilterHidden(isHidden: true)
        favoritesViewDelegate.removeFilter()
    }
    
    func removeFilterHidden(isHidden: Bool) {
        removeFilterButton.isHidden = isHidden
    }
    
}

extension FavoritesView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(removeFilterButton)
        stackView.addArrangedSubview(tableView)
    }
    
    func setupConstraints() {
        stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        removeFilterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        removeFilterButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive = true
        removeFilterButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        removeFilterButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true

        tableView.topAnchor.constraint(equalTo: removeFilterButton.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }
}

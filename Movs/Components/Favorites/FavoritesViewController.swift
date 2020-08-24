//
//  FavoritesViewController.swift
//  Movs
//
//  Created by gustavo.cosenza on 22/08/20.
//  Copyright © 2020 gustavo.cosenza. All rights reserved.
//

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
    
//    var favorites: [FavoritesCD] = []
    let favoritesManager = FavoriteManager()
    let core = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Favorites"
        
        navigationController!.navigationBar.tintColor = .black
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "colorYellow")
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(filterClicked))
        filterButton.tintColor = .black
        self.navigationItem.rightBarButtonItem  = filterButton
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
        
         NSLayoutConstraint.activate([
        tableView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        tableView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        tableView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
                   ])
        
        core.getFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.core.getFavorites()
            self.tableView.reloadData()
        }
    }
    
    
    @objc private func filterClicked() {
        let filterController = FilterViewController()
        navigationController!.pushViewController(filterController, animated: true)
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return core.favorites.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FavoriteTableViewCell
            cell.prepare(with: core.favorites[indexPath.row])
            return cell
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                favoritesManager.deleteFavorite(index: indexPath.row)
                self.core.getFavorites()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
}


//extension FavoritesViewController: NSFetchedResultsControllerDelegate{
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//
//        switch type {
//        case .delete:
//            if let indexPath = indexPath{
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                print("deleta tableview")
//            }
//        default:
//            tableView.reloadData()
//        }
//    }
//}

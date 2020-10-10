

import UIKit

class HomeViewCoordinator: Coordinator {
    
    var rootViewController: UIViewController

    private let presenter: UINavigationController
    
    init() {
        self.rootViewController = HomeViewController()
        presenter = UINavigationController()
//        rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        
        
        presenter.pushViewController(rootViewController, animated: true)
    }
}

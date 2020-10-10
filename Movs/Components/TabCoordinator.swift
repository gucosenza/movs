import UIKit

class TabCoordinator: Coordinator {
    
    let window: UIWindow
    
    var rootViewController: UIViewController {
        return tabController
    }
    
    var tabController: UITabBarController
    
    var homeCoordinator: HomeViewCoordinator
    //    let historyCoordinator: HistoryCoordinator
    
    var coordinators: [Coordinator] {
        //        return [homeCoordinator, historyCoordinator, profileCoordinator]
        return [homeCoordinator]
    }
    
    init(window: UIWindow) { //4
        self.window = window
        self.tabController = UITabBarController()
        self.homeCoordinator = HomeViewCoordinator()
    }
    
    func start() {
//        historyCoordinator = HistoryCoordinator(client: client, persistence: persistence)
        
        var controllers: [UIViewController] = []
        
        let homeViewController = homeCoordinator.rootViewController
        homeViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
        
//        let historyViewController = historyCoordinator.rootViewController
//        historyViewController.tabBarItem = UITabBarItem(title: Localization.walletTab.string, image: Asset.iconMenuWallet.image, selectedImage: Asset.iconMenuWalletActivated.image)

        
        controllers.append(homeViewController)
//        controllers.append(historyViewController)
        
        tabController.viewControllers = controllers
        tabController.tabBar.isTranslucent = false
//        tabController.delegate = self
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}




//tabBar.isTranslucent = false
//tabBar.tintColor = .black
//tabBar.barTintColor = UIColor(named: "colorYellow")
//
//let homeViewController = HomeViewController()
//homeViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
//
//let favoritesViewController = FavoritesViewController()
//favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), tag: 1)
//
//let viewControllerList = [ homeViewController, favoritesViewController ]
//viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }


import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.barTintColor = UIColor(named: "colorYellow")

        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), tag: 1)
        
        let viewControllerList = [ homeViewController, favoritesViewController ]
//        let viewControllerList = [ favoritesViewController, homeViewController ]
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }
}


import UIKit

enum ViewControllerItem: Int {
    case first = 0
    case second = 1
}

protocol TabBarSourceType {
    var items: [UINavigationController] {get set}
}

final class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]
    
    init() {
        self[.first].tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), selectedImage: UIImage(named: "list_icon"))
        self[.second].tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), selectedImage: UIImage(named: "favorite_empty_icon"))
    }
}

// transform the index of the item in "items" into a case of the enum ViewControllerItem
extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exist")
            }
            return items[item.rawValue]
        }
    }
}

final class TabCoordinator: NSObject, Coordinator {
    
    private let presenter: UIWindow
    private let tabBarController: UITabBarController
    private var firstCoordinator: HomeCoordinator?
    private var secondCoordinator: FavoritesCoordinator?
    private var source: TabBarSource = TabBarSource()
    
    init(presenter: UIWindow) {
        self.presenter = presenter
        
        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = source.items
        tabBarController.selectedViewController = source[.first]
        
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.barTintColor = UIColor(named: "colorYellow")
        super.init()
        
        tabBarController.delegate = self
    }
    
    func start() {
        presenter.rootViewController = tabBarController
        showFirstTab()
    }
    
    private func showFirstTab() {
        firstCoordinator = HomeCoordinator(presenter: source[.first])
        firstCoordinator?.start()
    }
    
    private func showSecondTab() {
        secondCoordinator = FavoritesCoordinator(presenter: source[.second])
        secondCoordinator?.start()
    }
}

// get the rawvalue of the selected item, and call the relative func show()
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < source.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Index out of range")
        }
        
        switch item {
        case .first:
            showFirstTab()
        case .second:
            showSecondTab()
        }
    }
}

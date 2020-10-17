import UIKit

final class FavoritesCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    let viewController = FavoritesViewController()
    private var filterCoordinator: FilterCoordinator?
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // MARK: - Coordinator
    
    func start() {
        viewController.coordinator = self
        presenter.viewControllers = [viewController]
    }
    
    func applyFilter(){
        viewController.applyFilter()
        start()
    }
}

extension FavoritesCoordinator: FavoritesViewCoordinator {
    func favoritesViewControllerSelectFilter() {
        let filterCoordinator = FilterCoordinator(presenter: presenter)
        filterCoordinator.start()
        self.filterCoordinator = filterCoordinator
    }
}

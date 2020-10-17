
import UIKit

class FilterCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    var filterViewController = FilterViewController()
    var favoritesCoordinator: FavoritesCoordinator?
    var optionFilterCoordinator: OptionFilterCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        filterViewController.filterViewControllerCoordinator = self
        presenter.pushViewController(filterViewController, animated: true)
    }

}

extension FilterCoordinator: FilterViewControllerCoordinator {
    func listFilterOption(optionFilter: FilterTypes) {
        let optionFilterCoordinator = OptionFilterCoordinator(presenter: presenter, optionFilter: optionFilter)
        optionFilterCoordinator.start()
        self.optionFilterCoordinator = optionFilterCoordinator
    }
    
    func applyFilter() {
        let favoritesCoordinator = FavoritesCoordinator(presenter: self.presenter)
        favoritesCoordinator.applyFilter()
        self.favoritesCoordinator = favoritesCoordinator
    }
}


import UIKit

class OptionFilterCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    var optionFilter: FilterTypes
    var optionFilterViewController: OptionFilterViewController?
    var filterCoordinator: FilterCoordinator?
    
    init(presenter: UINavigationController, optionFilter: FilterTypes) {
        self.presenter = presenter
        self.optionFilter = optionFilter
    }
    
    func start() {
        let optionFilterViewController = OptionFilterViewController(optionFilter: optionFilter)
        optionFilterViewController.coordinator = self
        presenter.pushViewController(optionFilterViewController, animated: true)
        self.optionFilterViewController = optionFilterViewController
    }
}

extension OptionFilterCoordinator: OptionFilterViewControllerCoordinator {
    func optionChosen() {
//        let filterCoordinator = FilterCoordinator(presenter: presenter)
//        filterCoordinator.start()
//        self.filterCoordinator = filterCoordinator
        presenter.popViewController(animated: true)
    }
}


//        self.navigationController?.popViewController(animated: true)

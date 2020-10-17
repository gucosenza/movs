import UIKit

final class HomeCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var detailCoordinator: DetailCoordinator?
    let viewController = HomeViewController()
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        viewController.coordinator = self
        presenter.viewControllers = [viewController]
    }
}

extension HomeCoordinator: HomeViewControllerCoordinator {
    func homeViewControllerDidSelectMovie(movie: Movie) {
        let detailCoordinator = DetailCoordinator(presenter: presenter, movie: movie)
        detailCoordinator.start()
        
        self.detailCoordinator = detailCoordinator
    }
}

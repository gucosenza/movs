
import UIKit

class DetailCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let movie: Movie
    
    init(presenter: UINavigationController, movie: Movie) {
        self.presenter = presenter
        self.movie = movie
    }
    
    func start() {
        showDetailViewController()
    }
    
    func showDetailViewController() {
        let viewController = DetailViewController(movie: movie)
        presenter.pushViewController(viewController, animated: true)
    }
}


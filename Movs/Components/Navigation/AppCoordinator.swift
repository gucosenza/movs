import UIKit

final class AppCoordinator: Coordinator {
    
    private unowned var sceneDelegate: SceneDelegate
    private var tabcoordinator: TabCoordinator?
    
    init(sceneDelegate: SceneDelegate) {
        self.sceneDelegate = sceneDelegate
    }
    
    func start() {
        tabcoordinator = TabCoordinator(presenter: sceneDelegate.window!)
        tabcoordinator?.start()
    }
}

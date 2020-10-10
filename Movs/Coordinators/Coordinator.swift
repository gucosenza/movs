
import UIKit

protocol Coordinator {
    var rootViewController: UIViewController { get }
    func start()
}

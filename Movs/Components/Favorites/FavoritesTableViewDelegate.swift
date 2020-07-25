

import UIKit

class FavoritesTableViewDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }

}

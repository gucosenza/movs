
import UIKit


class FavoritesView: UIView {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = .white
        return table
    }()
   
   override init(frame: CGRect) {
       super.init(frame: frame)
       
       addSubview(tableView)
       
       NSLayoutConstraint.activate([
           tableView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
           tableView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
           tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
           tableView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
           ])
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}

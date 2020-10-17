
import UIKit

class HomeView: UIView {
    
    lazy var ai: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.style = .large
        return ai
    }()
    
    lazy var uiViewLoading: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let border = (( UIScreen.main.bounds.width - (185*2)) / 3)
        layout.sectionInset = UIEdgeInsets(top: 10, left: border, bottom: 0, right: border)
        layout.itemSize = CGSize(width: 185, height: 308)
        layout.minimumInteritemSpacing = ((UIScreen.main.bounds.width - (185*2)) / 3)
        layout.minimumLineSpacing = ((UIScreen.main.bounds.width - (185*2)) / 3)
        var collect = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collect.backgroundColor = .white
        collect.translatesAutoresizingMaskIntoConstraints = false
        return collect
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        uiViewLoading.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpinner() {
        uiViewLoading.isHidden = false
        ai.startAnimating()
    }
    
    func removeSpinner() {
        ai.stopAnimating()
        uiViewLoading.isHidden = true
    }
    
}

extension HomeView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(collectionView)
        self.addSubview(uiViewLoading)
        uiViewLoading.addSubview(ai)
    }
    
    func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        uiViewLoading.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        uiViewLoading.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        uiViewLoading.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        uiViewLoading.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        ai.centerXAnchor.constraint(equalTo: uiViewLoading.centerXAnchor).isActive = true
        ai.centerYAnchor.constraint(equalTo: uiViewLoading.centerYAnchor).isActive = true
    }
}

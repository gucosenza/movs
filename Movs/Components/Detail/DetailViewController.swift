import UIKit

protocol DetailViewProtocol {
    func didFavorite()
}

class DetailViewController: UIViewController, DetailViewProtocol {
    
    private let favoriteManager = FavoriteManager()
    private let genreManager = GenreManager()
    var movie: Movie!
    
    private let detailView: DetailView = {
        let view = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        detailView.detailViewProtocol = self
        detailView.configure(movie: movie, isFavorite: favoriteManager.isFavorite(idMovie: movie.id), genreLabel: genreManager.getGenres(ids: movie.genreIDS))
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didFavorite(){
        if favoriteManager.isFavorite(idMovie: movie.id) {
            favoriteManager.deleteFavorite(movie: movie)
        } else {
            favoriteManager.saveFavorite(movie: movie)
        }
//        self.detailView.
//        self.homeCollectionView.collectionView.reloadData()
        DispatchQueue.main.async {
//            self.detailView.reloadInputViews()
            self.reloadInputViews()
        }
    }
    
}

extension DetailViewController: CodeView {
    func buildViewHierarchy() {
        self.view.addSubview(detailView)
    }
    
    func setupConstraints() {
        detailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        detailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        detailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        detailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = UIColor(named: "colorWhite")
        self.title = "Movie"
        navigationController!.navigationBar.tintColor = .black
    }
}

import UIKit

protocol DetailViewProtocol {
    func didFavorite()
}

class DetailViewController: UIViewController {
    
    private let favoriteManager = FavoriteManager.shared
    private var genreManager = GenreManager.shared
    var movie: Movie!
    let detailView = DetailView()
    
    override func loadView() {
        self.view = detailView
        self.view.backgroundColor = UIColor(named: "colorWhite")
        self.title = "Movie"
        navigationController!.navigationBar.tintColor = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

extension DetailViewController: DetailViewProtocol {
    func didFavorite(){
        self.favoriteManager.saveFavorite(movie: self.movie)
    }
}

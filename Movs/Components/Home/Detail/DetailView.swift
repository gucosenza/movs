
import UIKit

class DetailView: UIView {
    
    var movie: Movie!
    var imageManager = ImageManager()
    var isFavorite: Bool!
    
    var detailViewProtocol: DetailViewProtocol!
        
    private lazy var backdrop: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var overviewTextView: UITextView = {
        let overview = UITextView()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = UIFont.systemFont(ofSize: 17)
        overview.textColor = .black
        overview.isEditable = false
        return overview
    }()
    
    private lazy var viewLineTitle: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewLineYear: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewLineGenre: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupViews()
        }
    
    func configure(movie: Movie, isFavorite: Bool, genreLabel: String) {
        self.movie = movie
        self.isFavorite = isFavorite
        self.genreLabel.text = genreLabel
    
        backdrop.image = imageManager.getImage(type: .backdrop, image: movie.backdropPath ?? "")
        titleLabel.text = movie.title
        if isFavorite == true {
            favoriteButton.setBackgroundImage(UIImage(named: "favorite_full_icon") as UIImage?, for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(named: "favorite_empty_icon") as UIImage?, for: .normal)
        }
        yearLabel.text = movie.releaseYear
        overviewTextView.text = movie.overview
    }
    
        @objc func buttonClicked(){
            if !isFavorite {
                favoriteButton.setBackgroundImage(UIImage(named: "favorite_full_icon") as UIImage?, for: .normal)
                detailViewProtocol.didFavorite()
            }
            
        }
}

    extension DetailView: CodeView {
        func buildViewHierarchy() {
            addSubview(titleLabel)
            addSubview(backdrop)
            addSubview(favoriteButton)
            addSubview(viewLineTitle)
            addSubview(yearLabel)
            addSubview(viewLineYear)
            addSubview(genreLabel)
            addSubview(viewLineGenre)
            addSubview(overviewTextView)
        }
        
        func setupConstraints() {
            labelConstraint()
            backdropConstraint()
            favoriteButtonConstraint()
            yearConstraint()
            genreConstraint()
            overviewConstraint()
            viewLineConstraint()
        }
        
        func backdropConstraint(){
            backdrop.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
            backdrop.heightAnchor.constraint(equalToConstant: 210).isActive = true
            backdrop.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            backdrop.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
            backdrop.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
        }
        
        func labelConstraint(){
            titleLabel.topAnchor.constraint(equalTo: backdrop.bottomAnchor, constant: 15).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -5).isActive = true //direita
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
        }
        
        func favoriteButtonConstraint() {
            favoriteButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
            favoriteButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
            favoriteButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
            favoriteButton.topAnchor.constraint(equalTo: backdrop.bottomAnchor, constant: 15).isActive = true
        }
        
        func yearConstraint() {
            yearLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            yearLabel.topAnchor.constraint(equalTo: viewLineTitle.bottomAnchor, constant: 10).isActive = true
            yearLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
            yearLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
        }
        
        func genreConstraint() {
            genreLabel.topAnchor.constraint(equalTo: viewLineYear.bottomAnchor, constant: 10).isActive = true
            genreLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true //esquerda
            genreLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true //direita
        }
        
        func overviewConstraint(){
            overviewTextView.leadingAnchor.constraint(equalTo: viewLineGenre.leadingAnchor).isActive = true
            overviewTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
            overviewTextView.topAnchor.constraint(equalTo: viewLineGenre.bottomAnchor, constant: 10).isActive = true
            overviewTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        }
        
        func viewLineConstraint(){
            viewLineTitle.heightAnchor.constraint(equalToConstant: 1).isActive = true
            viewLineTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            viewLineTitle.leadingAnchor.constraint(equalTo: yearLabel.leadingAnchor).isActive = true
            viewLineTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
            
            viewLineYear.heightAnchor.constraint(equalToConstant: 1).isActive = true
            viewLineYear.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            viewLineYear.leadingAnchor.constraint(equalTo: yearLabel.leadingAnchor).isActive = true
            viewLineYear.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 10).isActive = true
            
            viewLineGenre.heightAnchor.constraint(equalToConstant: 1).isActive = true
            viewLineGenre.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            viewLineGenre.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor).isActive = true
            viewLineGenre.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10).isActive = true
        }
    }


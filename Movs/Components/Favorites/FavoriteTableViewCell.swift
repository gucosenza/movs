
import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    let imageManager = ImageManager()

    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "colorDarkBlue")
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "colorDarkBlue")
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "colorDarkBlue")
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    func prepare(with favorite:FavoritesCD) {
        posterImage.image = imageManager.posterImage(poster_path: favorite.image!)
        titleLabel.text = favorite.name
        yearLabel.text = favorite.year
        overviewLabel.text = favorite.overview
        
        setupViews()
    }
}

extension FavoriteTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        posterConstraint()
        titleConstraint()
        yearConstraint()
        overviewConstraint()
    }
    
    func posterConstraint(){
        posterImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true //esquerda
        posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 1).isActive = true
    }
    
    func titleConstraint(){
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10).isActive = true //esquerda
        titleLabel.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor, constant: 5).isActive = true //direita
    }
    func yearConstraint(){
        yearLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true //direita
    }
    
    func overviewConstraint(){
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 10).isActive = true //esquerda
        overviewLabel.trailingAnchor.constraint(equalTo: yearLabel.trailingAnchor).isActive = true //direita
        overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        contentView.backgroundColor = .lightGray
    }
}

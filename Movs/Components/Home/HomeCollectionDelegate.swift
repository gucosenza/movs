
import UIKit

class HomeCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var detailProtocol: DetailProtocol!
    
    var view: UIView!
    var movies: [Movie]
    
    init(view: UIView, movies: [Movie]) {
        self.view = view
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let border = ((self.view.bounds.width - (185*2)) / 3)
        return UIEdgeInsets(top: 10, left: border, bottom: 0, right: border)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 185, height: 308)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ((self.view.bounds.width - (185*2)) / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ((self.view.bounds.width - (185*2)) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = collectionView.indexPathsForSelectedItems?.first {
            detailProtocol.navigationDetailViewController(movie: movies[index.row])
        }
    }
    
}

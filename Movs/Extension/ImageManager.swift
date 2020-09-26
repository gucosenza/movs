import UIKit

enum ImageType {
    case backdrop
    case poster
}

final class ImageManager {
    func getImage(type: ImageType, image: String) -> UIImage {
        if !image.isEmpty{
            var urlImage: URL!
            switch type {
            case .backdrop:
                urlImage = ImageEndpoints.backdropPath(image).url
            case .poster:
                urlImage = ImageEndpoints.posterPath(image).url
            }
            if let data = try? Data(contentsOf: urlImage) {
                if let image = UIImage(data: data) {
                    return image
                }
            }
        }
        return UIImage(named: "no-image-found-360x260.png")!
    }
}

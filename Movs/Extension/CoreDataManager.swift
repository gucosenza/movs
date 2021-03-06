
import UIKit
import CoreData

class CoreDataManager {
    
    private var genreManager = GenreManager.shared

    func getFavorites() -> [FavoritesCD] {
        var favorites: [FavoritesCD] = []
        
        guard let appDelegate =
           UIApplication.shared.delegate as? AppDelegate else {
             return []
         }

         let managedContext = appDelegate.persistentContainer.viewContext

         let fetchRequest = NSFetchRequest<FavoritesCD>(entityName: "FavoritesCD")
         let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
         fetchRequest.sortDescriptors = [sortDescriptor]

         do {
           favorites = try managedContext.fetch(fetchRequest)
         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
        return favorites
    }

    func saveFavorite(movie: Movie) {

            guard let appDelegate =
              UIApplication.shared.delegate as? AppDelegate else {
              return
            }

            let managedContext = appDelegate.persistentContainer.viewContext

            let entity = NSEntityDescription.entity(forEntityName: "FavoritesCD", in: managedContext)!

            let favoriteTemp = NSManagedObject(entity: entity, insertInto: managedContext)
            favoriteTemp.setValue(movie.title, forKeyPath: "name")
            favoriteTemp.setValue(movie.posterPath, forKeyPath: "image")
            favoriteTemp.setValue(Int32(movie.id), forKeyPath: "movieId")
            favoriteTemp.setValue(movie.overview, forKeyPath: "overview")
            favoriteTemp.setValue(String(movie.releaseDate.dropLast(6)), forKeyPath: "year")
            favoriteTemp.setValue(genreManager.getGenres(ids: movie.genreIDS), forKey: "genre")

            do {
              try managedContext.save()
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }

        }

    func deleteFavorite(index: Int) {
        var favorites: [FavoritesCD] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<FavoritesCD>(entityName: "FavoritesCD")
        //        fetchRequest.predicate = NSPredicate(format: "movieId = %@", "\(favorite.movieId)")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            favorites = try managedContext.fetch(fetchRequest)
            managedContext.delete(favorites[index])
            
            do {
                try managedContext.save()
            } catch  {
                print(error)
            }
            
        } catch {
            print(error)
        }
        
    }

}

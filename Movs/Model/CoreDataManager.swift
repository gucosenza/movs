
import UIKit
import CoreData

class CoreDataManager {

    var favorites: [FavoritesCD] = []
    
    func getFavorites() {
        
        guard let appDelegate =
           UIApplication.shared.delegate as? AppDelegate else {
             return
         }
         
         let managedContext =
           appDelegate.persistentContainer.viewContext
         
         let fetchRequest =
           NSFetchRequest<FavoritesCD>(entityName: "FavoritesCD")
         let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
         fetchRequest.sortDescriptors = [sortDescriptor]
         
         do {
           favorites = try managedContext.fetch(fetchRequest)
         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
    }
    
    func saveFavorite(favorite: FavoritesCD) {
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "FavoritesCD", in: managedContext)!
        
        let favoriteTemp = NSManagedObject(entity: entity, insertInto: managedContext)
        
        favoriteTemp.setValue(favorite.name, forKeyPath: "name")
        favoriteTemp.setValue(favorite.image, forKeyPath: "image")
        favoriteTemp.setValue(favorite.movieId, forKeyPath: "movieId")
        favoriteTemp.setValue(favorite.overview, forKeyPath: "overview")
        favoriteTemp.setValue(favorite.year, forKeyPath: "year")

        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        
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
        
            do {
              try managedContext.save()
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
    
    func deleteFavorite(favorite: FavoritesCD) {
        print("cheguei")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
//        let fetchRequest = NSFetchRequest<FavoritesCD>(entityName: "FavoritesCD")
//
//        fetchRequest.predicate = NSPredicate(format: "movieId == %@", favorite.movieId)

        do {
//          let deleteFavorite = try managedContext.fetch(fetchRequest)
//            managedContext.delete(deleteFavorite[0])
            managedContext.delete(favorite)
//            managedContext.deletedObjects(favorite as NSManagedObject)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
}
//let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//let context:NSManagedObjectContext = appDel.managedObjectContext
//
//let index = sender.tag
//
//context.deleteObject(people[index] as NSManagedObject)

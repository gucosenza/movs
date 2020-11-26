

import XCTest
@testable import Movs

class FilterManagerTests: XCTestCase {

    var sut = FilterManager.shared
    var arrayFavorites: [FavoritesCD] = []
    
    override func setUp() {
//        guard let appDelegate =
//          UIApplication.shared.delegate as? AppDelegate else {
//          return
//        }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "FavoritesCD", in: managedContext)!
//        let favoriteTemp = NSManagedObject(entity: entity, insertInto: managedContext)
//
//        let favorite1 = FavoritesCD()
//        favorite1.setValue("terror", forKey: "genre")
//        favorite1.setValue("Teste Um", forKeyPath: "name")
//        favorite1.setValue("2020", forKeyPath: "year")
//
//        let favorite2 = FavoritesCD()
//        favorite2.setValue("comédia", forKey: "genre")
//        favorite2.setValue("Teste Dois", forKeyPath: "name")
//        favorite2.setValue("2019", forKeyPath: "year")
//
//        arrayFavorites = [favorite1, favorite2]
    }

    override func tearDown() {
        sut.setGenreOption(genre: "")
        sut.setDateOption(date: "")
    }
    
    func test_setGetDate() {
        sut.setDateOption(date: "2020")
        XCTAssertEqual(sut.getDateOption(), "2020")
    }
    
    func test_setGetGenre() {
        sut.setGenreOption(genre: "terror")
        XCTAssertEqual(sut.getGenreOption(), "terror")
    }
    
    func test_filterFavoritesWhitoutFilter() {
        sut.setGenreOption(genre: "terror")
        sut.setDateOption(date: "2020")
        let result = sut.filter(favorites: arrayFavorites)
        XCTAssertEqual(result.count, 0)
    }

}



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

//        let favorite1 = FavoritesCD()
//        favorite1.genre = "terror"
//        favorite1.name = "Teste Um"
//        favorite1.year = "2020"
//
//        let favorite2 = FavoritesCD()
//        favorite2.genre = "comédia"
//        favorite2.name = "Teste Dois"
//        favorite2.year = "2019"
//
//        arrayFavorites.append(favorite1)
//        arrayFavorites.append(favorite2)
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

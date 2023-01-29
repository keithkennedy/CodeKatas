import XCTest
@testable import Potter

final class PotterTests: XCTestCase {
    func testEmptyBasket() throws {
        let emptyBasket: [Int] = [Int]()
        XCTAssertEqual(0, Potter.GetPrice(basket: emptyBasket))
    }

    func testSingleItemBaskets() throws {
        XCTAssertEqual(8 , Potter.GetPrice(basket: [0]))
        XCTAssertEqual(8 , Potter.GetPrice(basket: [1]))
        XCTAssertEqual(8 , Potter.GetPrice(basket: [2]))
        XCTAssertEqual(8 , Potter.GetPrice(basket: [3]))
        XCTAssertEqual(8 , Potter.GetPrice(basket: [4]))
    }
    
    func testStandardBaskets() throws {
        XCTAssertEqual(8 * 3, Potter.GetPrice(basket: [1,1,1]))
        XCTAssertEqual(8 * 2 * 0.95, Potter.GetPrice(basket: [0, 1]))
        XCTAssertEqual(8 * 3 * 0.9, Potter.GetPrice(basket: [0, 2, 4]))
        XCTAssertEqual(8 * 4 * 0.8, Potter.GetPrice(basket: [0, 1, 2, 4]))
        XCTAssertEqual(8 * 5 * 0.75, Potter.GetPrice(basket: [0, 1, 2, 3, 4]))
    }

    func testComplexBaskets() throws {
        XCTAssertEqual(8 + 8 * 2 * 0.95, Potter.GetPrice(basket: [0, 0, 1]))
        XCTAssertEqual(2 * 8 * 2 * 0.95, Potter.GetPrice(basket: [0, 0, 1, 1]))
        // (8 * 4 * 0.8) + (8 * 2 * 0.95)
        XCTAssertEqual(25.6 + 15.2, Potter.GetPrice(basket: [0, 0, 1, 2, 2, 3]))
        XCTAssertEqual(8 + (8 * 5 * 0.75), Potter.GetPrice(basket: [0, 1, 1, 2, 3, 4]))
    }

    func testEdgeCases() throws {
        XCTAssertEqual(2 * (8 * 4 * 0.8), Potter.GetPrice(basket: [0, 0, 1, 1, 2, 2, 3, 4]))
        // 3 * (8 * 5 * 0.75) + 2 * (8 * 4 * 0.8)
        XCTAssertEqual(3 * 30 + 2 * 25.6 , Potter.GetPrice(basket: [0, 0, 0, 0, 0, 
            1, 1, 1, 1, 1, 
            2, 2, 2, 2, 
            3, 3, 3, 3, 3, 
            4, 4, 4, 4]))
    }
}

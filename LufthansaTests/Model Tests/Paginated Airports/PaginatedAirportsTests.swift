import XCTest
@testable import Lufthansa

class PaginatedAirportsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDecodeArrayAirports() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedAirportMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let airports = try? JSONDecoder().decode(PaginatedAirports.self, from: jsonData)
            XCTAssert(airports?.airports.count == 20)
            XCTAssert(airports?.total == 11658)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeSingleAirport() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedAirportSingleMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let airports = try? JSONDecoder().decode(PaginatedAirports.self, from: jsonData)
            XCTAssert(airports?.airports.count == 1)
            XCTAssert(airports?.total == 1)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidKeys() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedAirportKeyMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let airports = try? JSONDecoder().decode(PaginatedAirports.self, from: jsonData)
            XCTAssertNil(airports)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidKeys2() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedAirportKey2Mock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let airports = try? JSONDecoder().decode(PaginatedAirports.self, from: jsonData)
            XCTAssert(airports?.total == 0)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidTypes() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedAirportTypeMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let airports = try? JSONDecoder().decode(PaginatedAirports.self, from: jsonData)
            XCTAssertNil(airports)
        } else {
            XCTAssert(false)
        }
    }
}

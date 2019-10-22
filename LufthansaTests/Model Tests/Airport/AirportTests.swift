import XCTest
@testable import Lufthansa

class AirportTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDecodeValidAirport() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "AirportMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let airport = try? JSONDecoder().decode(Airport.self, from: jsonData)
            XCTAssertEqual(airport?.code, "AAA")
            XCTAssertEqual(airport?.name, "Anaa")
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeValidAirportWithoutName() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "AirportMissingMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let airport = try? JSONDecoder().decode(Airport.self, from: jsonData)
            XCTAssertEqual(airport?.code, "AAA")
            XCTAssertEqual(airport?.name, "")
        } else {
            XCTAssert(false)
        }
    }

    func testDecodeInvalidAirportKey() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "AirportKeyMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let airport = try? JSONDecoder().decode(Airport.self, from: jsonData)
             XCTAssertNil(airport)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidAirportType() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "AirportValueMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let airport = try? JSONDecoder().decode(Airport.self, from: jsonData)
             XCTAssertNil(airport)
        } else {
            XCTAssert(false)
        }
    }

    func testGetNameFormattedWithName() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "AirportMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let airport = try? JSONDecoder().decode(Airport.self, from: jsonData)
             XCTAssertEqual(airport?.getNameFormatted(), "AAA - Anaa")
        } else {
            XCTAssert(false)
        }
    }
    
    func testGetNameFormattedWithoutName() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "AirportMissingMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let airport = try? JSONDecoder().decode(Airport.self, from: jsonData)
             XCTAssertEqual(airport?.getNameFormatted(), "AAA")
        } else {
            XCTAssert(false)
        }
    }
    
}

import XCTest
@testable import Lufthansa

class LocationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDecodeValidLocation() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "LocationMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let location = try? JSONDecoder().decode(Location.self, from: jsonData)
            XCTAssertEqual(location?.latitude, -17.3525)
            XCTAssertEqual(location?.longitude, -145.51)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidLocationKey() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "LocationKeyMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let location = try? JSONDecoder().decode(Location.self, from: jsonData)
            XCTAssertNil(location)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidLocationValue() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "LocationValueMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let location = try? JSONDecoder().decode(Location.self, from: jsonData)
            XCTAssertNil(location)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidLocationMissingKey() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "LocationMissingMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let location = try? JSONDecoder().decode(Location.self, from: jsonData)
            XCTAssertNil(location)
        } else {
            XCTAssert(false)
        }
    }
    
}

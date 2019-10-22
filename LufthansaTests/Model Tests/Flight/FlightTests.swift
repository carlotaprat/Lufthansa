import XCTest
@testable import Lufthansa

class FlightTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDecodeValidFlight() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
            let origin = Date.init(timeIntervalSinceReferenceDate: 593497500.0)
            let destination = Date.init(timeIntervalSinceReferenceDate: 593503500.0)
            XCTAssertEqual(flight?.originTime, origin)
            XCTAssertEqual(flight?.destinationTime, destination)
            XCTAssertEqual(flight?.departureAirportCode, "BCN")
            XCTAssertEqual(flight?.destinationAirportCode, "ZRH")
        } else {
            XCTAssert(false)
        }
    }

    func testDecodeInvalidFlightKey1() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightKeyMock1", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidFlightKey2() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightKeyMock2", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidFlightKey3() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightKeyMock3", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidFlightKey4() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightKeyMock4", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidFlightKey5() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightKeyMock5", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidFlightType1() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightTypeMock1", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidFlightType2() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightTypeMock2", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidFlightType3() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightTypeMock3", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidFlightType4() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "FlightTypeMock4", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
             let flight = try? JSONDecoder().decode(Flight.self, from: jsonData)
             XCTAssertNil(flight)
        } else {
            XCTAssert(false)
        }
    }
    
}

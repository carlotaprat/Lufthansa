import XCTest
@testable import Lufthansa

class ScheduleTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDecodeArrayFlightsSchedule() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "ScheduleMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let schedule = try? JSONDecoder().decode(Schedule.self, from: jsonData)
            XCTAssert(schedule?.flights.count == 2)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeSchedule() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "ScheduleSingleMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let schedule = try? JSONDecoder().decode(Schedule.self, from: jsonData)
            XCTAssert(schedule?.flights.count == 1)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidKeys() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "ScheduleKeyMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let schedule = try? JSONDecoder().decode(Schedule.self, from: jsonData)
            XCTAssert(schedule?.flights.count == 0)
        } else {
            XCTAssert(false)
        }
    }
    
}

import XCTest
@testable import Lufthansa

class PaginatedSchedulesTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDecodeArrayPaginatedSchedules() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedSchedulesMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let schedules = try? JSONDecoder().decode(PaginatedSchedules.self, from: jsonData)
            XCTAssert(schedules?.items.count == 11)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeSinglePaginatedSchedules() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedSchedulesSingleMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let schedules = try? JSONDecoder().decode(PaginatedSchedules.self, from: jsonData)
            XCTAssert(schedules?.items.count == 1)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidKeys() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedSchedulesKeyMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let schedules = try? JSONDecoder().decode(PaginatedSchedules.self, from: jsonData)
            XCTAssert(schedules == nil)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidKeys2() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedSchedulesKeyMock2", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let schedules = try? JSONDecoder().decode(PaginatedSchedules.self, from: jsonData)
            XCTAssert(schedules?.items.count == 0)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeMissingKey() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "PaginatedSchedulesMissingMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let schedules = try? JSONDecoder().decode(PaginatedSchedules.self, from: jsonData)
            XCTAssert(schedules?.items.count == 0)
        } else {
            XCTAssert(false)
        }
    }
}

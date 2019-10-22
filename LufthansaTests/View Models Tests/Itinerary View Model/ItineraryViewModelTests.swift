import XCTest
@testable import Lufthansa

class ItineraryViewModelTests: XCTestCase {

    var viewModel: ItineraryViewModel!
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        let path1 = bundle.path(forResource: "AirportOriginMock", ofType: "json")!
        let path2 = bundle.path(forResource: "AirportDestinationMock", ofType: "json")!

        guard let jsonData = NSData(contentsOfFile: path1) as? Data,
            let jsonData2 = NSData(contentsOfFile: path2) as? Data else {
                return
        }
         if let originAirport = try? JSONDecoder().decode(Airport.self, from: jsonData),
            let destinationAirport = try? JSONDecoder().decode(Airport.self, from: jsonData2) {
            viewModel = ItineraryViewModel(originAirport: originAirport, destinationAirport: destinationAirport)
        }
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testGetMaxX() {
        XCTAssertEqual(viewModel.getMaxX(), -50)
    }
    
    func testGetMinX() {
        XCTAssertEqual(viewModel.getMinX(), -145)
    }
    
    func testGetMaxY() {
        XCTAssertEqual(viewModel.getMaxY(), -10)
    }
    
    func testGetMinY() {
        XCTAssertEqual(viewModel.getMinY(), -17)
    }
    
    func testGetCenterX() {
        XCTAssertEqual(Int(viewModel.getCenter(longitude: true)), -96)
    }
    
    func testGetCenterY() {
        XCTAssertEqual(Int(viewModel.getCenter(longitude: false)), -19)
    }
    
    func testGetSpanX() {
        XCTAssertEqual(Int(viewModel.getSpan(x: true)), 104)
    }
    
    func testGetSpanY() {
        XCTAssertEqual(Int(viewModel.getSpan(x: false)), 7)
    }
    
    func testGetOriginCoords() {
        XCTAssertEqual(viewModel.getOriginCoords().latitude, -17)
        XCTAssertEqual(viewModel.getOriginCoords().longitude, -145)
    }
    
    func testGetDestinationCoords() {
        XCTAssertEqual(viewModel.getDestinationCoords().latitude, -10)
        XCTAssertEqual(viewModel.getDestinationCoords().longitude, -50)
    }
    
    func testGetOriginAirportString() {
        XCTAssertEqual("AAA - Anaa", viewModel.getOriginAirportString())
    }
    
    func testGetDestinationAirportString() {
        XCTAssertEqual("BBB - Beaa", viewModel.getDestinationAirportString())

    }
    
    

}

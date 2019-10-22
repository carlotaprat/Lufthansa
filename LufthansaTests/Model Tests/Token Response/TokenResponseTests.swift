import XCTest
@testable import Lufthansa

class TokenResponseTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDecodeValidToken() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "TokenMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: jsonData)
            XCTAssertEqual(tokenResponse?.token, "x4p5w3smpwueex45nsknewsa")
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidTokenKey() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "TokenKeyMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: jsonData)
            XCTAssertNil(tokenResponse)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeInvalidType() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "TokenValueMock", ofType: "json")!
        if let jsonData = NSData(contentsOfFile: path) as? Data {
            let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: jsonData)
            XCTAssertNil(tokenResponse)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDecodeMissingTokenKey() {
        let bundle = Bundle(for: type(of: self))
         let path = bundle.path(forResource: "TokenMissingMock", ofType: "json")!
         if let jsonData = NSData(contentsOfFile: path) as? Data {
             let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: jsonData)
             XCTAssertNil(tokenResponse)
         } else {
             XCTAssert(false)
         }
    }
    
}

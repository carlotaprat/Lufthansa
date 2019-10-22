//
//  SchedulesListViewModelTests.swift
//  LufthansaTests
//
//  Created by José Luis on 22/10/2019.
//  Copyright © 2019 carlotaprat. All rights reserved.
//

import XCTest
@testable import Lufthansa


class SchedulesListViewModelTests: XCTestCase {

    var viewModel: SchedulesListViewModel!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        let path1 = bundle.path(forResource: "SchedulesViewModelMock", ofType: "json")!
        let path2 = bundle.path(forResource: "AirportOriginMock", ofType: "json")!
        let path3 = bundle.path(forResource: "AirportDestinationMock", ofType: "json")!

        guard let jsonData = NSData(contentsOfFile: path1) as? Data,
            let jsonData2 = NSData(contentsOfFile: path2) as? Data,
            let jsonData3 = NSData(contentsOfFile: path3) as? Data
            else {
                return
        }
         if let originAirport = try? JSONDecoder().decode(Airport.self, from: jsonData2),
            let destinationAirport = try? JSONDecoder().decode(Airport.self, from: jsonData3),
            let schedules = try? JSONDecoder().decode(PaginatedSchedules.self, from: jsonData) {
            let date = Date()
            viewModel = SchedulesListViewModel(origin: originAirport, destination: destinationAirport, date: date)
            viewModel.schedules = schedules.items
        }
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testGetOriginAirport() {
        XCTAssertEqual(viewModel.getOriginAirport().name, "Anaa")
        XCTAssertEqual(viewModel.getOriginAirport().code, "AAA")
    }
    
    func testGetDestinationAirport() {
        XCTAssertEqual(viewModel.getDestinationAirport().name, "Beaa")
        XCTAssertEqual(viewModel.getDestinationAirport().code, "BBB")
    }

    func testResetPagination() {
        XCTAssertEqual(viewModel.schedules.count, 11)
        viewModel.resetPagination()
        XCTAssertEqual(viewModel.schedules.count, 0)
    }
    
    func testGetSchedulesCount() {
        XCTAssertEqual(viewModel.schedules.count, 11)
    }
    
    func testGetSchedule() {
        XCTAssertEqual(viewModel.getSchedule(index: 0)?.flights.first?.departureAirportCode, "BCN")
    }
    
    func testGetTotalSchedules() {
        XCTAssertEqual(viewModel.schedules.count, 11)
    }

}

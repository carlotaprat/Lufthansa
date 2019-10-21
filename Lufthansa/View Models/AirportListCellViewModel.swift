import Foundation

class AirportListCellViewModel {
    
    let airport: Airport
    
    init(airport: Airport) {
        self.airport = airport
    }
    
    func getAirportName() -> String {
        return self.airport.name
    }
    
    func getAirportShortname() -> String {
        return self.airport.code
    }
    
}

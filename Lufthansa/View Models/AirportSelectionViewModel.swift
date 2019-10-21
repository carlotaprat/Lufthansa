import Foundation

class AirportSelectionViewModel {
    
    private var originAirport: Airport?
    private var destinationAirport: Airport?
    
    func setOriginAirport(airport: Airport) {
        originAirport = airport
    }
    
    func setDestinationAirport(airport: Airport) {
        destinationAirport = airport
    }
    
    func getOriginAirport() -> Airport? {
        return originAirport
    }
    
    func getDestinationAirport() -> Airport? {
        return destinationAirport
    }
}

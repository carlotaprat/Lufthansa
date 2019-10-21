import Foundation

class ItineraryViewModel {
    
    private let originAirport: Airport
    private let destinationAirport: Airport
    
    init(originAirport: Airport, destinationAirport: Airport) {
        self.originAirport = originAirport
        self.destinationAirport = destinationAirport
    }
    
    func getMaxX() -> Double {
        return max(originAirport.position.longitude, destinationAirport.position.longitude)
    }
    
    func getMinX() -> Double {
           return min(originAirport.position.longitude, destinationAirport.position.longitude)
    }
    
    func getMaxY() -> Double {
        return max(originAirport.position.latitude, destinationAirport.position.latitude)
    }
    
    func getMinY() -> Double {
        return min(originAirport.position.latitude, destinationAirport.position.latitude)
    }
    
    func getCenter(longitude: Bool) -> Double {
        let lat1 = destinationAirport.position.latitude * .pi / 180
        let lon1 = destinationAirport.position.longitude * .pi / 180
        let x1 = cos(lat1) * cos(lon1)
        let y1 = cos(lat1) * sin(lon1)
        let z1 = sin(lat1)
        let lat2 = originAirport.position.latitude * .pi / 180
        let lon2 = originAirport.position.longitude * .pi / 180
        let x2 = cos(lat2) * cos(lon2)
        let y2 = cos(lat2) * sin(lon2)
        let z2 = sin(lat2)
        let x = (x1 + x2) / 2
        let y = (y1 + y2) / 2
        let z = (z1 + z2) / 2
        var lon = atan2(y, x)
        let hyp = sqrt(x*x + y*y)
        var lat = atan2(z, hyp)
        lat = lat * 180 / .pi
        lon = lon * 180 / .pi
        if longitude {
            return lon
        }
        return lat
    }
    
    func getSpan(x: Bool) -> Double {
        if x {
            return fabs(getMaxX() - getMinX()) * 1.1
        } else {
            return fabs(getMaxY() - getMinY()) * 1.1
        }
    }
    
    func isOriginTop() -> Bool {
        if originAirport.position.latitude >= destinationAirport.position.latitude &&
            originAirport.position.longitude <= destinationAirport.position.longitude {
            return true
        }
        return false
    }
    
    func getOriginCoords() -> Location {
        return originAirport.position
    }
    
    func getDestinationCoords() -> Location {
        return destinationAirport.position
    }
    
    func getOriginAirportString() -> String {
        return originAirport.code + " - " + originAirport.name
    }
    
    func getDestinationAirportString() -> String {
        return destinationAirport.code + " - " + destinationAirport.name
    }
}


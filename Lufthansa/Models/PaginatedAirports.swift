import Foundation

class PaginatedAirports: Decodable {
    
    let airports: [Airport]
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case base = "AirportResource"
    }
    
    enum AirportsCodingKeys: String, CodingKey {
        case airports = "Airports"
        case meta = "Meta"
    }
    
    enum MetaCodingKeys: String, CodingKey {
        case total = "TotalCount"
    }
    
    enum AirportCodingKeys: String, CodingKey {
        case airport = "Airport"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let airportsContainer = try container.nestedContainer(keyedBy: AirportsCodingKeys.self, forKey: .base)
        let airportsContainer2 = try airportsContainer.nestedContainer(keyedBy: AirportCodingKeys.self, forKey: .airports)
        do {
            self.airports = try airportsContainer2.decode([Airport].self, forKey: .airport)
        } catch {
            let airport = try airportsContainer2.decode(Airport.self, forKey: .airport)
            self.airports = [airport]
        }
        let metaContainer = try airportsContainer.nestedContainer(keyedBy: MetaCodingKeys.self, forKey: .meta)
        self.total = try metaContainer.decodeIfPresent(Int.self, forKey: .total) ?? 1
    }
}

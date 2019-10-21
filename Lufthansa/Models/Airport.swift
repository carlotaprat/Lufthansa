import Foundation

class Airport: Decodable {
    
    let name: String
    let position: Location
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case names = "Names"
        case positions = "Position"
        case code = "CityCode"
    }
    
    enum NameCodingKeys: String, CodingKey {
        case name1 = "Name"
        case content = "$"
    }
    
    enum PositionCodingKeys: String, CodingKey {
        case coord = "Coordinate"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let positionContainer = try container.nestedContainer(keyedBy: PositionCodingKeys.self, forKey: .positions)
        let coordinate = try positionContainer.decode(Location.self, forKey: .coord)
        self.position = coordinate
        self.code = try container.decode(String.self, forKey: .code)
        if container.contains(.names) {
            let namesContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .names)
            let nameContainer = try namesContainer.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name1)
            self.name = try nameContainer.decode(String.self, forKey: .content)
        } else {
            self.name = ""
        }
    }
    
    func getNameFormatted() -> String {
        if self.name == "" {
            return self.code
        }
        return self.code + " - " + self.name
    }
}

class Location: Decodable {
    
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}


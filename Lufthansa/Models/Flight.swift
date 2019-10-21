import Foundation

class Flight: Decodable {
    
    let originTime: Date
    let destinationTime: Date
    let departureAirportCode: String
    let destinationAirportCode: String
    
    enum ScheduleCodingKeys: String, CodingKey {
        case departure = "Departure"
        case arrival = "Arrival"
    }
    
    enum TimeCodingKeys: String, CodingKey {
        case time = "ScheduledTimeLocal"
        case code = "AirportCode"
    }
    
    enum DateCodingKeys: String, CodingKey {
        case date = "DateTime"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ScheduleCodingKeys.self)
        let departure = try container.nestedContainer(keyedBy: TimeCodingKeys.self, forKey: .departure)
        let arrival = try container.nestedContainer(keyedBy: TimeCodingKeys.self, forKey: .arrival)
        let localTimeOrigin = try departure.nestedContainer(keyedBy: DateCodingKeys.self, forKey: .time)
        let localTimeDestination = try arrival.nestedContainer(keyedBy: DateCodingKeys.self, forKey: .time)
        self.departureAirportCode = try departure.decode(String.self, forKey: .code)
        self.destinationAirportCode = try arrival.decode(String.self, forKey: .code)
        let originTimeString = try localTimeOrigin.decode(String.self, forKey: .date)
        let destinationTimeString = try localTimeDestination.decode(String.self, forKey: .date)
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
         dateFormatter.locale = Locale.current
         self.originTime = dateFormatter.date(from: originTimeString) ?? Date()
        self.destinationTime = dateFormatter.date(from: destinationTimeString) ?? Date()
    }
}

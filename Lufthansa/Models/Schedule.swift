import Foundation

class Schedule: Decodable {
    
    let flights: [Flight]
    
    enum CodingKeys: String, CodingKey {
        case flight = "Flight"
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                let airport = try container.decode(Flight.self, forKey: .flight)
                self.flights = [airport]
            } catch {
                let airport = try container.decode([Flight].self, forKey: .flight)
                self.flights = airport
            }
        } catch {
            self.flights = []
        }
    }
}

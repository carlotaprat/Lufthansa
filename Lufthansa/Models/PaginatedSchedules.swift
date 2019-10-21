import Foundation

class PaginatedSchedules: Decodable {
    
    var items: [Schedule]
    
    enum CodingKeys: String, CodingKey {
        case base = "ScheduleResource"
    }
    
    enum CodingKeys1: String, CodingKey {
        case schedules = "Schedule"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let schedulesContainer = try container.nestedContainer(keyedBy: CodingKeys1.self, forKey: .base)
        do {
            let items = try schedulesContainer.decode([Schedule].self, forKey: .schedules)
            self.items = items
        } catch {
            do {
                let item = try schedulesContainer.decode(Schedule.self, forKey: .schedules)
                self.items = [item]
            } catch {
                self.items = []
            }

        }
    }
}

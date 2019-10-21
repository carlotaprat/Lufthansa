import Foundation

enum APIUrls: String {
    
    case token = "oauth/token"
    case airports = "mds-references/airports"
    case airportsSearch = "mds-references/airports/%@"
    case schedules = "operations/schedules/%@/%@/%@"

    var getUrl: String {
        return "https://api.lufthansa.com/v1/\(self.rawValue)"
    }
}

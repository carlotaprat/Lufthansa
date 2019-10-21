import Foundation

protocol DataService {
    
    func getToken(onSuccess: @escaping (_ response: TokenResponse?) -> Void, onError: @escaping (_ error: LufthansaError) -> Void)
    
    func fetchAirports(offset: Int, limit: Int, onSuccess: @escaping (_ response: PaginatedAirports?) -> Void, onError: @escaping (_ error: LufthansaError) -> Void)
    
    func fetchSchedules(from: String, to: String, date: Date?, onSuccess: @escaping (_ response: [Schedule]?) -> Void, onError: @escaping (_ error: LufthansaError) -> Void)
    
    func searchAirport(code:String, onSuccess: @escaping(_ pagination: PaginatedAirports?) -> Void, onError: @escaping (_ error: LufthansaError) -> Void)
}

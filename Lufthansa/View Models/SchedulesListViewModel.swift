import Foundation

class SchedulesListViewModel {
    
    private let originAirport: Airport
    private let destinationAirport: Airport
    private let date: Date?
    var dataService: DataService = APIService()
    var schedules: [Schedule] = []
    private var currentPage = 0
    private var total = 0
    private var limit = 100
    private var offset = 0
    private let minCurrentPage = 1
    
    init(origin: Airport, destination: Airport, date: Date) {
        self.originAirport = origin
        self.destinationAirport = destination
        self.date = date
    }
    
    func getOriginAirport() -> Airport {
        return originAirport
    }
    
    func getDestinationAirport() -> Airport {
        return destinationAirport
    }
 
    func resetPagination() {
        self.schedules.removeAll()
        total = 0
        offset = 0
    }

    func fetchSchedules(onSuccess: @escaping (Bool) -> Void, onError: @escaping (_ error: LufthansaError) -> Void) {
        dataService.fetchSchedules(from: originAirport.code, to: destinationAirport.code, date: self.date, onSuccess: { response in
                guard let schedules = response else {
                    onError(.internalError)
                   return
                }
                self.schedules = schedules
                onSuccess(true)
           }, onError: { error in
                self.schedules = []
                onError(error)
           })
       }
    

    func getSchedulesCount() -> Int {
        return schedules.count
    }

    func getSchedule(index: Int) -> Schedule? {
        guard schedules.count > index else {
            return nil
        }
        return schedules[index]
    }

    func getTotalSchedules() -> Int {
        return total
    }
}

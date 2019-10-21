import Foundation

class AirportListViewModel {
    
    var dataService: DataService = APIService()
    var airports: [Airport] = []
    private var currentPage = 0
    private var total = 0
    private var limit = 100
    private var offset = 0
    private let minCurrentPage = 1

    func resetPagination() {
        self.airports.removeAll()
        total = 0
        offset = 0
    }

    func fetchAirports(onSuccess: @escaping (Bool) -> Void, onError: @escaping (_ error: LufthansaError) -> Void) {
       
        dataService.fetchAirports(offset: self.offset, limit: self.limit, onSuccess: { response in
           guard let paginatedAirports = response else {
               onError(.internalError)
               return
           }
           self.currentPage += self.minCurrentPage
           self.total = paginatedAirports.total
           if self.currentPage == self.minCurrentPage {
               self.airports.removeAll()
           }
           self.airports.append(contentsOf: paginatedAirports.airports)
           self.offset = self.airports.count + 1
           
           onSuccess(true)
           
       }, onError: { error in
           onError(error)
       })
   }

    func searchAirport(code: String, onSuccess: @escaping (Bool) -> Void, onError: @escaping (_ error: LufthansaError) -> Void) {
              
        dataService.searchAirport(code: code, onSuccess: { response in
            guard let paginatedAirports = response else {
                onError(.internalError)
                return
            }
            self.resetPagination()
            self.airports = paginatedAirports.airports
            onSuccess(true)
        }, onError: { error in
            self.airports = []
            self.resetPagination()
            onError(error)
          })
        }
    

    func getAirportsCount() -> Int {
        return airports.count
    }

    func getAirport(index: Int) -> Airport? {
        guard airports.count > index else {
            return nil
        }
        return airports[index]
    }

    func getTotalAirports() -> Int {
        return total
    }
}

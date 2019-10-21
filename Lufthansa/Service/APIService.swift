import Foundation
import Alamofire

struct APIService: DataService {
    
    let searchTextKey = "airportCode"
    
    func getToken(onSuccess: @escaping (_ response: TokenResponse?) -> Void, onError: @escaping (_ error: LufthansaError) -> Void) {
        
        let url = String(format: ServiceHelper.app.getUrl(url: .token))
        let params = ServiceHelper.app.tokenParameters() as Parameters
      
        AF.request(url, method: .post, parameters: params)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        onError(.internalError)
                        return
                    }
                    do {
                        let request = try JSONDecoder().decode(TokenResponse.self, from: data)
                        onSuccess(request)
                        
                    } catch {
                        onError(.authenticationError)
                    }
                case .failure:
                    onError(.authenticationError)
                }
            }
    }

    
    func fetchAirports(offset: Int, limit: Int, onSuccess: @escaping(_ pagination: PaginatedAirports?) -> Void, onError: @escaping (_ error: LufthansaError) -> Void) {
        let url = String(format: ServiceHelper.app.getUrl(url: .airports))
        let headers = HTTPHeaders.init(ServiceHelper.app.tokenHeaders)
        let parameters = ServiceHelper.app.paginationParameters(offset: offset, limit: limit)
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        onError(.internalError)
                        return
                    }
                    do {
                        let request = try JSONDecoder().decode(PaginatedAirports.self, from: data)
                        onSuccess(request)
                    } catch {
                        onError(.internalError)
                    }
                case .failure:
                    if let code = response.response?.statusCode {
                        switch code {
                        case 404:
                            onError(.noResultsError)
                        case 400:
                            onError(.serviceError)
                        default:
                            onError(.serviceError)
                        }
                    } else {
                        onError(.serviceError)
                    }
                }
            }
    }
    
    func searchAirport(code:String, onSuccess: @escaping(_ pagination: PaginatedAirports?) -> Void, onError: @escaping (_ error: LufthansaError) -> Void) {
        
        let url = String(format: ServiceHelper.app.getUrl(url: .airportsSearch), code)
        let headers = HTTPHeaders.init(ServiceHelper.app.tokenHeaders)
        let parameters = ServiceHelper.app.languageParameters
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        onError(.internalError)
                        return
                    }
                    do {
                        let request = try JSONDecoder().decode(PaginatedAirports.self, from: data)
                        onSuccess(request)
                    } catch {
                        onError(.internalError)
                    }
                case .failure:
                    if let code = response.response?.statusCode {
                        switch code {
                        case 404:
                            onError(.noResultsError)
                        case 400:
                            onError(.serviceError)
                        default:
                            onError(.serviceError)
                        }
                    } else {
                        onError(.serviceError)
                    }
                }
            }
    }
    
    func fetchSchedules(from: String, to: String, date: Date?, onSuccess: @escaping (_ response: [Schedule]?) -> Void, onError: @escaping (_ error: LufthansaError) -> Void) {
        var myDate = ""
        if let date = date {
            myDate = DateHelper.app.getString(from: date)
        } else {
            myDate = ServiceHelper.app.currentDate
        }
        let url = String(format: ServiceHelper.app.getUrl(url: .schedules), from, to, myDate)
        let headers = HTTPHeaders.init(ServiceHelper.app.tokenHeaders)
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        onError(.internalError)
                        return
                    }
                    do {
                        let request = try JSONDecoder().decode(PaginatedSchedules.self, from: data)
                        onSuccess(request.items)
                    } catch {
                        onError(.internalError)
                    }
                case .failure:
                    if let code = response.response?.statusCode {
                        switch code {
                        case 404:
                            onError(.noResultsError)
                        case 400:
                            onError(.serviceError)
                        default:
                            onError(.serviceError)
                        }
                    } else {
                        onError(.serviceError)
                    }
                }
            }
    }

}

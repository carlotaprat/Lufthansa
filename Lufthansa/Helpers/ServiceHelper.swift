import Foundation
import SwiftKeychainWrapper
import Alamofire

class ServiceHelper {
    
    let myPrivateKey = "client_secret"
    let myPublicKey = "client_id"
    let grantTypeKey = "grant_type"
    let grantTypeValue = "client_credentials"
    let offsetKey = "offset"
    let token = "token"
    let acceptKey = "Accept"
    let acceptValue = "application/json"
    let authKey = "Authorization"
    let authValue = "Bearer "
    let langKey = "lang"
    let englishValue = "EN"
    let limitKey = "limit"
    
    static var app: ServiceHelper = {
        return ServiceHelper()
    }()
        
    var tokenHeaders: [String: String] {
        get {
            var header = [acceptKey: acceptValue]
            if let token = KeychainWrapper.standard.string(forKey: token) {
                header[authKey] = authValue + token
            }
            return header
        }
    }
    
    var languageParameters: Parameters {
        get {
            let param: Parameters = [langKey: englishValue]
            return param
        }
    }
    
    var currentDate: String {
        get {
            let date = Date()
            return DateHelper.app.getString(from: date)
        }
    }
    
    func paginationParameters(offset: Int, limit: Int) -> Parameters {
        var param: Parameters = [
            offsetKey: offset,
            limitKey: limit
        ]
        let paramLang = self.languageParameters
        param.merge(dict: paramLang)
        return param
    }
    
    func tokenParameters() -> Parameters{
        let params: Parameters = [
            myPublicKey: KeychainWrapper.standard.string(forKey: myPublicKey) ?? "",
            myPrivateKey: KeychainWrapper.standard.string(forKey: myPrivateKey) ?? "",
            grantTypeKey: grantTypeValue
        ]
        return params
    }
    
    func getUrl(url: APIUrls) -> String {
        return url.getUrl
    }
    
}

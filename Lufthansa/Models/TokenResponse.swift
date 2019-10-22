import Foundation

class TokenResponse: Decodable {
    
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
    
}

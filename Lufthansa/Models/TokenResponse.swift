import Foundation

class TokenResponse: Decodable {
    
    var token: String
    var expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case expiresIn = "expires_in"
    }
    
}

@testable import Firebase
import Foundation
import Vapor

extension FirebaseAPIRequest {
    
    static func dummy(client: Client) -> FirebaseAPIRequest {
        return FirebaseAPIRequest(httpClient: client, apiKey: "NOAPIKEY")
    }
    
}

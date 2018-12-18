import Foundation
@testable import Firebase
@testable import Vapor

extension FirebaseAPIRequest {
    
    static func dummy(client: Client) -> FirebaseAPIRequest {
        return FirebaseAPIRequest(httpClient: client, apiKey: "NOAPIKEY")
    }
    
}

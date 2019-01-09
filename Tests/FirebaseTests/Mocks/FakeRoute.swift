@testable import Firebase
import Vapor

class FakeRoute {
    
    private let request: FirebaseRequest
    
    init(request: FirebaseRequest) {
        self.request = request
    }
    
    /// Fake route for testing purpose
    public func sendRequest(method: HTTPMethod = .GET, url: String = "", query: String = "", body: String = "", headers: HTTPHeaders = [:]) throws -> Future<DummyResponse> {
        return try request.send(method: method,
                                url: url,
                                query: query,
                                body: HTTPBody(string: body),
                                headers: headers)
    }
}

struct DummyResponse: FirebaseModel { }

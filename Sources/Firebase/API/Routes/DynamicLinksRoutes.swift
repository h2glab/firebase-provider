import Vapor

public protocol DynamicLinksRoutes {
    func createShortLink(param: DynamicLinkRequest) throws -> Future<DynamicLink>
}

public struct FirebaseDynamicLinksRoutes: DynamicLinksRoutes {

    private let request: FirebaseRequest
    
    init(request: FirebaseRequest) {
        self.request = request
    }

    /// Create short links
    /// [Learn More →](https://firebase.google.com/docs/reference/dynamic-links/link-shortener)
    public func createShortLink(param: DynamicLinkRequest) throws -> Future<DynamicLink> {
        return try request.send(method: .POST,
                                url: FirebaseAPIEndpoint.DynamicLinks.shortLinks.endpoint,
                                query: "",
                                body: HTTPBody(string: param.toEncodedBody()),
                                headers: [:])
    }
}

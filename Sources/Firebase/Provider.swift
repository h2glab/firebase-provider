import Vapor

public struct FirebaseConfig: Service {
    public let apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}

public final class FirebaseProvider: Provider {

    public static let repositoryName = "firebase-provider"

    public init() { }

    public func boot(_ worker: Container) throws { }

    public func didBoot(_ worker: Container) throws -> EventLoopFuture<Void> {
        return .done(on: worker)
    }

    public func register(_ services: inout Services) throws {
        services.register { (container) -> FirebaseClient in
            let httpClient = try container.make(Client.self)
            let config = try container.make(FirebaseConfig.self)
            return FirebaseClient(apiKey: config.apiKey, client: httpClient)
        }
    }
}

public final class FirebaseClient: Service {

    public var dynamicLinks: DynamicLinksRoute

    internal init(apiKey: String, client: Client) {
        let apiRequest = FirebaseAPIRequest(httpClient: client, apiKey: apiKey)

        dynamicLinks = FirebaseDynamicLinksRoute(request: apiRequest)
    }
}

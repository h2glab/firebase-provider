@testable import Vapor

class ContainerStub: Container {
    public let config: Config = .default()
    public var environment: Vapor.Environment = .testing
    public let services: Services = .default()
    public let serviceCache: ServiceCache = .init()
    public var eventLoop: EventLoop = EmbeddedEventLoop()
    
    public init() {}
}

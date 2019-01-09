import Foundation
@testable import Firebase

extension DynamicLinkRequest {

    static var dummy: DynamicLinkRequest {
        return DynamicLinkRequest(dynamicLink: DynamicLinkRequest.DynamicLink(link: URL(string: "http://link")!), suffix: DynamicLinkRequest.Suffix(option: .SHORT))
    }
}

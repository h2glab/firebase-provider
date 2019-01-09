import Foundation
@testable import Firebase

extension DynamicLinkRequest {

    static let dummy = DynamicLinkRequest(dynamicLink: DynamicLinkRequest.DynamicLink(link: URL(string: "http://link")!), suffix: DynamicLinkRequest.Suffix(option: .SHORT))
}

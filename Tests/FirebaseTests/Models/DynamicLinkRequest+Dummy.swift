import Foundation
@testable import Firebase

extension DynamicLinkRequest {

    static var dummy: DynamicLinkRequest {
        return DynamicLinkRequest(dynamicLink: DynamicLinkInfo(link: "http://link"), suffix: Suffix(option: .SHORT))
    }
}

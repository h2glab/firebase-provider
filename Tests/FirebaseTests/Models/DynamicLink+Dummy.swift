import Foundation
@testable import Firebase

extension DynamicLink {

    static let dummy = DynamicLink(shortLink: URL(string: "https://shortLink")!, previewLink: URL(string: "https://previewLink")!, warning: nil)
}

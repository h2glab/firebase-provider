import Foundation
@testable import Firebase

extension DynamicLink {
    
    static var dummy: DynamicLink {
        return DynamicLink(shortLink: URL(string: "https://shortLink")!, previewLink: URL(string: "https://previewLink")!)
    }
}

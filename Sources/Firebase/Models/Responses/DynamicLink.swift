import Foundation

public struct DynamicLink: FirebaseModel {

    public let shortLink: URL
    public let previewLink: URL
    public let warning: [Warning]?

    public struct Warning: FirebaseModel {
        public let code: String
        public let message: String

        enum CodingKeys : String, CodingKey {
            case code = "warningCode"
            case message = "warningMessage"
        }
    }
}
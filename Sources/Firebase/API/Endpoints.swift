import Foundation

internal let APIBase = "https://firebasedynamiclinks.googleapis.com/"
internal let APIVersion = "v1/"

internal enum FirebaseAPIEndpoint {

    internal enum DynamicLinks: String {
        // MARK: - Short Links
        case shortLinks

        var endpoint: String {
            switch self {
            case .shortLinks: return APIBase + APIVersion + self.rawValue
            }
        }
    }
}

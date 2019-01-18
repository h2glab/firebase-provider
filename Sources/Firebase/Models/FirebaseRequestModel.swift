import Vapor

public protocol FirebaseRequestModel: Content {
    func toEncodedBody() throws -> String
}

extension FirebaseRequestModel {
    public func toEncodedBody() throws -> String {
        let encoded = try JSONEncoder().encode(self)

        let jsonString = String(data: encoded, encoding: .utf8) ?? ""
        return jsonString
    }
}

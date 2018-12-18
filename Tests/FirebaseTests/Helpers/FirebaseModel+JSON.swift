import Foundation
@testable import Firebase

extension FirebaseModel {

    public func toJson() throws -> String {
        let encoded = try JSONEncoder().encode(self)

        let jsonString = String(data: encoded, encoding: .utf8) ?? ""
        return jsonString
    }
}
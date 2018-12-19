import Foundation
import Vapor

public struct FirebaseError: FirebaseModel, Error, Debuggable {
    public var identifier: String {
        return String(self.error.code.rawValue)
    }
    public var reason: String {
        return self.error.message
    }
    public var error: FirebaseAPIError
    
    init(error: Error) {
        self.error = FirebaseAPIError(code: .unknown, message: error.localizedDescription)
    }
}

public struct FirebaseAPIError: FirebaseModel {
    public var code: FirebaseErrorCode
    public var message: String
    public var status: String?
    
    init(code: FirebaseErrorCode, message: String, status: String? = nil) {
        self.code = code
        self.message = message
        self.status = status
    }
}

public enum FirebaseErrorCode: Int, FirebaseModel {
    case permissionDeniedError = 403
    case unknown = -1
}

extension FirebaseErrorCode: Codable {
    public init(from decoder: Decoder) throws {
        self = try FirebaseErrorCode(rawValue: decoder.singleValueContainer().decode(Int.self)) ?? .unknown
    }
}

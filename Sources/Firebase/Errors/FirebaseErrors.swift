import Foundation
import Vapor

public struct FirebaseError: FirebaseModel, Error, Debuggable {
    public var identifier: String {
        return self.error
    }
    public var reason: String {
        return self.error
    }
    public var error: String
}
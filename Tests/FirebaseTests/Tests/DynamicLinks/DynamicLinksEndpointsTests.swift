@testable import Firebase
import Vapor
import XCTest

final class DynamicLinksEndpointsTests: XCTestCase {
    
    func test_shortLinkEndpoint_value() throws {
        // Given
        let expectedEnpoint = "https://firebasedynamiclinks.googleapis.com/v1/shortLinks"

        // When
        let endpoint = FirebaseAPIEndpoint.DynamicLinks.shortLinks.endpoint

        // Then
        XCTAssertEqual(endpoint, expectedEnpoint)
    }

    static var allTests = [
        ("test_shortLinkEndpoint_value", test_shortLinkEndpoint_value),
        ]
}

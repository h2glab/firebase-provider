import XCTest
@testable import Firebase
@testable import Vapor

final class DynamicLinksEndpointsTests: XCTestCase {
    
    func test_shortinkEndpoint_value() throws {
        // Given
        let expectedEnpoint = "https://firebasedynamiclinks.googleapis.com/v1/shortLinks"
        
        // When
        let endpoint = FirebaseAPIEndpoint.DynamicLinks.shortLinks.endpoint
        
        // Then
        XCTAssertEqual(endpoint, expectedEnpoint)
    }
    
    static var allTests = [
        ("test_shortinkEndpoint_value", test_shortinkEndpoint_value),
        ]
}

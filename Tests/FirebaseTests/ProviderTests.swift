import XCTest
@testable import Firebase

final class ProviderTests: XCTestCase {

    func test_firebaseConfig_should_containsApiKeWithoutModification() {
        // Given
        let expectedApiKey = "MyApiKey"

        // When
        let firebaseConfig = FirebaseConfig(apiKey: expectedApiKey)

        // Then
        XCTAssertEqual(firebaseConfig.apiKey, expectedApiKey)
    }

    func test_firebaseProvider_repositoryName_shouldNot_change() {
        // Given
        let expectedRepositoryName = "firebase-provider"

        // When

        // Then
        XCTAssertEqual(FirebaseProvider.repositoryName, expectedRepositoryName)
    }

    static var allTests = [
        ("test_firebaseConfig_should_containsApiKeWithoutModification", test_firebaseConfig_should_containsApiKeWithoutModification),
        ("test_firebaseProvider_repositoryName_shouldNot_change", test_firebaseProvider_repositoryName_shouldNot_change),
    ]
}

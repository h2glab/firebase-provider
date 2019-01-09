import XCTest
@testable import Firebase
@testable import Vapor

final class DynamicLinksRoutesTests: XCTestCase {

    func test_routeRequests_should_beInJson_when_encodedBody() throws {
        // Given
        let request = DynamicLinkRequest(dynamicLink: DynamicLinkRequest.DynamicLink(link: URL(string: "http://link")!),
                suffix: DynamicLinkRequest.Suffix(option: .SHORT))
        let expectedJson = "{\"suffix\":{\"option\":\"SHORT\"},\"dynamicLinkInfo\":{\"link\":\"http:\\/\\/link\"}}"

        // When
        let json = try request.toEncodedBody()

        // Then
        XCTAssertEqual(json, expectedJson)
    }

    func test_createShortLink_should_callShortLinksEndpointOnce_on_call() throws {
        // Given
        let httpClient = try ClientStub(responseText: DynamicLink.dummy.toJson())
        let route = FirebaseDynamicLinksRoute(request: FirebaseAPIRequest.dummy(client: httpClient))
        let request = DynamicLinkRequest.dummy
        let expectedJson = try request.toEncodedBody()

        // When
        let futureDynamicLink = try route.createShortLink(param: request)

        // Then
        futureDynamicLink.do { dynamicLink in
            let calls = httpClient.calls
            if let call = calls.first {
                XCTAssertEqual(String(data: call.body.convertToHTTPBody().data!, encoding: .utf8), expectedJson)
                XCTAssertEqual(call.method, .POST)
                XCTAssertEqual(call.headers[HTTPHeaderName.contentType].first, MediaType.json.description)
            } else {
                XCTFail("Expected a short links call")
            }
            XCTAssertEqual(calls.capacity, 1)
        }.catch { (error) in
            XCTFail("\(error)")
        }
    }

    static var allTests = [
        ("test_routeRequests_should_beInJson_when_encodedBody", test_routeRequests_should_beInJson_when_encodedBody),
        ("test_createShortLink_should_callShortLinksEndpointOnce_on_call", test_createShortLink_should_callShortLinksEndpointOnce_on_call),
    ]
}

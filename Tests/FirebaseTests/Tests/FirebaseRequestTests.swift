@testable import Firebase
import Vapor
import XCTest

final class FirebaseRequestTests: XCTestCase {
    
    func test_firebaseRequest_should_makeHttpCall_when_sendingRequest() throws {
        // Given
        let clientStub = ClientStub(responseText: "")
        let firebaseApiRequest = FirebaseAPIRequest.dummy(client: clientStub)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        
        // When
        let _ = try fakeRoute.sendRequest()
        
        // Then
        XCTAssertEqual(clientStub.calls.count, 1)
    }
    
    func test_firebaseRequest_should_addApiKeyToUrl_when_noPathProvided() throws {
        // Given
        let expectedApiKey = String.random(length: 10)
        let clientStub = ClientStub(responseText: "")
        let firebaseApiRequest = FirebaseAPIRequest(httpClient: clientStub, apiKey: expectedApiKey)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        
        // When
        let _ = try fakeRoute.sendRequest()
        
        // Then
        XCTAssertNotNil(clientStub.calls.first?.url.absoluteString.range(of: "?key=\(expectedApiKey)"))
    }
    
    func test_firebaseRequest_should_addApiKeyToUrl_when_pathProvided() throws {
        // Given
        let expectedApiKey = String.random(length: 10)
        let clientStub = ClientStub(responseText: "")
        let firebaseApiRequest = FirebaseAPIRequest(httpClient: clientStub, apiKey: expectedApiKey)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        
        // When
        let _ = try fakeRoute.sendRequest(query: "test=1")
        
        // Then
        XCTAssertNotNil(clientStub.calls.first?.url.absoluteString.range(of: "&key=\(expectedApiKey)"))
    }
    
    func test_firebaseRequest_should_callWithRightMethod_when_setSpecificMethod() throws {
        // Given
        let clientStub = ClientStub(responseText: "")
        let firebaseApiRequest = FirebaseAPIRequest.dummy(client: clientStub)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        
        let methodToValidate = [HTTPMethod.GET, HTTPMethod.POST, HTTPMethod.PATCH, HTTPMethod.PUT]
        try methodToValidate.forEach { methodToValidate in
            // When
            let _ = try fakeRoute.sendRequest(method: methodToValidate)
            
            // Then
            XCTAssertEqual(clientStub.calls.first?.method, methodToValidate)
            clientStub.reset()
        }
    }
    
    func test_firebaseRequest_should_callOnUrl_when_setSpecificUrl() throws {
        // Given
        let clientStub = ClientStub(responseText: "")
        let firebaseApiRequest = FirebaseAPIRequest.dummy(client: clientStub)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        
        // When
        let _ = try fakeRoute.sendRequest(url: "https://www.firebase.com")
        
        // Then
        XCTAssertEqual(clientStub.calls.first?.url.host, "www.firebase.com")
        XCTAssertEqual(clientStub.calls.first?.url.scheme, "https")
    }
    
    func test_firebaseRequest_should_addHeadersToRequest_when_callWithCustomHeaders() throws {
        // Given
        let clientStub = ClientStub(responseText: "")
        let firebaseApiRequest = FirebaseAPIRequest.dummy(client: clientStub)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        let expectedHeaderName = String.random(length: 10)
        let expectedHeaderValue = String.random(length: 10)
        
        // When
        let _ = try fakeRoute.sendRequest(headers: [expectedHeaderName: expectedHeaderValue])
        
        // Then
        guard let _ = clientStub.calls.first?.headers.contains(name: expectedHeaderName) else {
            XCTFail("Missing expected header name")
            return
        }
        XCTAssertEqual(clientStub.calls.first?.headers[expectedHeaderName].first, expectedHeaderValue)
    }
    
    func test_firebaseRequest_should_addQuery_when_callWithQuery() throws {
        // Given
        let clientStub = ClientStub(responseText: "")
        let firebaseApiRequest = FirebaseAPIRequest.dummy(client: clientStub)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        let expectedQueryName = String.random(length: 10)
        let expectedQueryValue = String.random(length: 10)
        let expectedQuery = "\(expectedQueryName)=\(expectedQueryValue)"
        
        // When
        let _ = try fakeRoute.sendRequest(query: expectedQuery)
        
        // Then
        XCTAssertNotNil(clientStub.calls.first?.url.query?.range(of: expectedQuery))
    }
    
    func test_firebaseRequest_should_addBody_when_callWithBodyData() throws {
        // Given
        let clientStub = ClientStub(responseText: "")
        let firebaseApiRequest = FirebaseAPIRequest.dummy(client: clientStub)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        let expectedBody = String.random(length: 10)
        
        // When
        let _ = try fakeRoute.sendRequest(body: expectedBody)
        
        // Then
        guard let call = clientStub.calls.first else {
            XCTFail("No body found")
            return
        }
        XCTAssertEqual(call.body.convertToHTTPBody().data, expectedBody.convertToHTTPBody().data)
    }
    
    func test_firebaseRequest_should_returnError_when_callFailed() throws {
        // Given
        let clientStub = ClientStub(withError: FirebaseError(error: "Error during API call"))
        let firebaseApiRequest = FirebaseAPIRequest.dummy(client: clientStub)
        let fakeRoute = FakeRoute(request: firebaseApiRequest)
        let body = String.random(length: 10)
        
        // When
        let result = try fakeRoute.sendRequest(body: body)
        
        // Then
        let _ = result.do { _ in
            XCTFail("Expected an error but no error has been raised")
        }
    }
    
    static var allTests = [
        ("test_firebaseRequest_should_makeHttpCall_when_sendingRequest", test_firebaseRequest_should_makeHttpCall_when_sendingRequest),
        ("test_firebaseRequest_should_addApiKeyToUrl_when_noPathProvided", test_firebaseRequest_should_addApiKeyToUrl_when_noPathProvided),
        ("test_firebaseRequest_should_addApiKeyToUrl_when_pathProvided", test_firebaseRequest_should_addApiKeyToUrl_when_pathProvided),
        ("test_firebaseRequest_should_callWithRightMethod_when_setSpecificMethod", test_firebaseRequest_should_callWithRightMethod_when_setSpecificMethod),
        ("test_firebaseRequest_should_callOnUrl_when_setSpecificUrl", test_firebaseRequest_should_callOnUrl_when_setSpecificUrl),
        ("test_firebaseRequest_should_addHeadersToRequest_when_callWithCustomHeaders", test_firebaseRequest_should_addHeadersToRequest_when_callWithCustomHeaders),
        ("test_firebaseRequest_should_addQuery_when_callWithQuery", test_firebaseRequest_should_addQuery_when_callWithQuery),
        ("test_firebaseRequest_should_addBody_when_callWithBodyData", test_firebaseRequest_should_addBody_when_callWithBodyData),
        ("test_firebaseRequest_should_returnError_when_callFailed", test_firebaseRequest_should_returnError_when_callFailed),
        ]
}

import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ProviderTests.allTests),
        testCase(FirebaseRequestTests.allTests),
        testCase(DynamicLinksRoutesTests.allTests),
        testCase(DynamicLinksEndpointsTests.allTests),
    ]
}
#endif
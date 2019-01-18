import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ProviderTests.allTests),
        testCase(FirebaseRequestTests.allTests),
    ]
}
#endif
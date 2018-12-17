import XCTest

import FirebaseTests

var tests = [XCTestCaseEntry]()
tests += ProviderTests.allTests()
XCTMain(tests)
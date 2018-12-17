import XCTest

import FirebaseTests

var tests = [XCTestCaseEntry]()
tests += FirebaseTests.allTests()
XCTMain(tests)
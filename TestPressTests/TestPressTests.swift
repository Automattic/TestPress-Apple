import XCTest
@testable import TestPress

class TestPressTests: XCTestCase {

    func testExample() throws {
        XCTAssertTrue(true)
    }

    func testBuildkiteTestAnalyticsToken() {
        XCTAssertNotNil(ProcessInfo.processInfo.environment["BUILDKITE_ANALYTICS_TOKEN"])
    }
}

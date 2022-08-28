import Foundation
import XCTest

public struct TestRunner {
    public init() { }
    
    public func runTests(testClass: AnyClass) {
        let tests = testClass as? XCTestCase.Type
        let suit = tests?.defaultTestSuite
        suit?.run()
    }
}

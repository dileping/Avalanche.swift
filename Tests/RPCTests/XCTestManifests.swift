#if !canImport(ObjectiveC)
import XCTest

extension RPCTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RPCTests = [
        ("testCall", testCall),
        ("testErrorDelegate", testErrorDelegate),
        ("testStress", testStress),
        ("testWsLong", testWsLong),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RPCTests.__allTests__RPCTests),
    ]
}
#endif
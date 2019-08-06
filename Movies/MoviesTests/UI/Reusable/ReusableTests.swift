@testable import Movies

import Nimble
import class XCTest.XCTestCase

final class ReusableTests: XCTestCase {
    func testShouldReturnCorretIdentifier() {
        let expectedDefault = String(describing: DefaultReusableImplementation.self)
        let expectedCustom = "Custom"

        let defaultReuseIdentifier = DefaultReusableImplementation.reuseIdentifier
        let customReuseIdentifier = CustomReusableImplementation.reuseIdentifier

        expect(defaultReuseIdentifier) == expectedDefault
        expect(customReuseIdentifier) == expectedCustom
    }
}

private final class DefaultReusableImplementation: Reusable { }

private final class CustomReusableImplementation: Reusable {
    static var reuseIdentifier: String { return "Custom" }
}

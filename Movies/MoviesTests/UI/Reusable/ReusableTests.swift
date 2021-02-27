@testable import Movies

import Nimble
import XCTest

private final class DefaultReusableImplementation: Reusable { }

private final class CustomReusableImplementation: Reusable {
    static var reuseIdentifier: String { "Custom" }
}

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

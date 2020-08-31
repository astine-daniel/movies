@testable import Movies

import Nimble
import UIKit
import XCTest

final class NibLoadableTests: XCTestCase {
    func testShouldReturnCorretBundle() {
        let expectedDefault = Bundle(for: DefaultNibLoadableImplementation.self)
        let expectedMain = Bundle.main

        let defaultBundle = DefaultNibLoadableImplementation.bundle
        let customBundle = CustomNibLoadableImplementation.bundle

        expect(defaultBundle) == expectedDefault
        expect(customBundle) == expectedMain
    }

    func testShouldReturnANib() {
        expect(DefaultNibLoadableImplementation.nib).toNot(beNil())
    }
}

private final class DefaultNibLoadableImplementation: NibLoadable { }

private final class CustomNibLoadableImplementation: NibLoadable {
    static var bundle: Bundle { return Bundle.main }
}

@testable import Movies

import class Foundation.Bundle
import class UIKit.UINib

import class XCTest.XCTestCase

import Nimble

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

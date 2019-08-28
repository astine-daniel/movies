@testable import Movies

import Foundation
import Nimble
import XCTest

final class DelegatedTests: XCTestCase {
    func testShouldntCreateCircularReference() {
        let deinitExpectation = XCTestExpectation(description: "Deinit expectation")
        var wasDeallocated = false

        var tester: Tester? = Tester()
        tester?.onDeinit = {
            wasDeallocated = true
            deinitExpectation.fulfill()
        }
        tester!.log()

        expect(tester!.logger.stringFromURL.isDelegateSet) == true

        tester = nil
        wait(for: [deinitExpectation], timeout: 10.0)

        expect(wasDeallocated) == true
    }
}

private extension DelegatedTests {
    final class Logger {
        var stringFromURL = Delegated<URL, String>()

        func log(url: URL) {
            guard let url = stringFromURL.call(url) else { return }
            print("Looger: \(url)")
        }
    }

    final class Tester {
        let logger: Logger

        var onDeinit: (() -> Void)?

        init() {
            logger = Logger()
            logger.stringFromURL.delegate(to: self) { (self, url) in
                return self.string(from: url)
            }
        }

        deinit {
            onDeinit?()
        }

        func log() {
            self.logger.log(url: URL(string: "https://www.delegated.com")!)
        }

        func string(from url: URL) -> String {
            return String(describing: url)
        }
    }
}

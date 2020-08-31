@testable import Movies

import Foundation
import Nimble
import XCTest

final class DelegatedTests: XCTestCase {
    func testShouldntCreateCircularReference() {
        let deinitExpectation = XCTestExpectation(description: "Deinit expectation")
        var wasDeallocated = false

        var tester: InputTester? = InputTester<URL>()
        tester?.onDeinit = {
            wasDeallocated = true
            deinitExpectation.fulfill()
        }
        tester!.log(URL(string: "https://test.com")!)

        expect(tester!.logger.outputFromInput.isDelegateSet) == true

        tester = nil
        wait(for: [deinitExpectation], timeout: 10.0)

        expect(wasDeallocated) == true
    }
}

private extension DelegatedTests {
    final class Logger<Input, Output> {
        var outputFromInput = Delegated<Input, Output>()

        func log(_ input: Input) {
            guard let output = outputFromInput.call(input) else { return }
            print("Looger: \(output)")
        }
    }

    final class InputTester<Input> {
        let logger: Logger<Input, String>

        var onDeinit: (() -> Void)?

        init() {
            logger = Logger()
            logger.outputFromInput.delegate(to: self) { (self, input) in
                return self.convert(input: input)
            }
        }

        deinit {
            onDeinit?()
        }

        func log(_ value: Input) {
            self.logger.log(value)
        }
    }
}

private extension DelegatedTests.InputTester {
    func convert(input: Input) -> String {
        return String(describing: input)
    }
}

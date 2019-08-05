import class XCTest.XCTestCase
import class XCTest.XCUIApplication

final class MoviesUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
}

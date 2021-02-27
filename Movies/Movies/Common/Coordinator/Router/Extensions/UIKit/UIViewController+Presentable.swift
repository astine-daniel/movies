import UIKit

extension UIViewController: Presentable {
    func toPresent() -> ScreenProtocol { self }
}

extension UIWindow: Presentable {
    // swiftlint:disable:next force_unwrapping
    func toPresent() -> ScreenProtocol { rootViewController! }
}

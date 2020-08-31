import UIKit

extension UIViewController: Presentable {
    func toPresent() -> ScreenProtocol { return self }
}

extension UIWindow: Presentable {
    func toPresent() -> ScreenProtocol { return rootViewController! }
}

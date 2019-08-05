import class UIKit.UIApplication
import protocol UIKit.UIApplicationDelegate
import class UIKit.UIResponder
import class UIKit.UIWindow

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

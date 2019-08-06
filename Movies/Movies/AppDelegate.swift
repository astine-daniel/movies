import protocol UIKit.UIApplicationDelegate

import class UIKit.UIApplication
import class UIKit.UINavigationController
import class UIKit.UIResponder
import class UIKit.UIScreen
import class UIKit.UIWindow

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: UpcomingMoviesListViewController())
        self.window?.makeKeyAndVisible()

        return true
    }
}

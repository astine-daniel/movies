import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    private lazy var applicationCoordinator = {
        return ApplicationCoordinator(router: Router(rootScreen: self.window!))
    }()

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        applicationCoordinator.start()

        self.window?.makeKeyAndVisible()

        return true
    }
}

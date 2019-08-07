import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let listController = UpcomingMoviesListViewController(UpcomingMoviesListView())
        let navigationController = NavigationController(rootViewController: listController)
        self.window?.rootViewController = navigationController

        listController.didSelectUpcomingMovie.delegate { _ in
            navigationController.pushViewController(UpcomingMovieDetailViewController(), animated: true)
        }

        self.window?.makeKeyAndVisible()

        return true
    }
}

import UIKit

final class ApplicationCoordinator: Coordinator {
    // MARK: - Properties
    private let router: RouterProtocol

    // MARK: - Initialization
    init(router: RouterProtocol) {
        self.router = router
    }

    // MARK: - Methods
    override func start() {
        let upcomingMoviesCoordinator = UpcomingMoviesCoordinator(
            router: NavigationRouter(navigationScreen: NavigationController()),
            respository: MoviesRepository())
        add(child: upcomingMoviesCoordinator)

        upcomingMoviesCoordinator.start()

        router.present(upcomingMoviesCoordinator, animated: true)
    }
}
